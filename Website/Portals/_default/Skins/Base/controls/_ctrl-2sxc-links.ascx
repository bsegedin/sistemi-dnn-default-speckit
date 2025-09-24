<%@ Control language="C#" Inherits="System.Web.UI.UserControl" %>
<%@ Import Namespace="ToSic.Sxc.Services" %>
<%@ Import Namespace="ToSic.Eav.Data" %>
<%@ Import Namespace="DotNetNuke.Services.FileSystem" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Web.Caching" %>
<%@ Import Namespace="System.Linq" %>

<script runat="server">
    // Define properties 2sxc PageLinks variables IMPORTANT!
    public string GroupName { get; set; } = "";
    public int ZoneId { get; set; } = 2;
    public int AppId { get; set; } = 5;
    // Cache duration in minutes
    public int CacheDuration { get; set; } = 60;
    
    public IEnumerable<IEntity> links;
    public IEnumerable<IEntity> linksFiltered;
    public int groupId = 0;
    public List<Dictionary<string, object>> updatedLinksFiltered = new List<Dictionary<string, object>>();
    public IEntity linkGroup;
    public string groupIconUrl = string.Empty;

    // Helper method for processing file references for icons
    private string GetIconUrl(string iconPath, Dictionary<int, string> fileUrls)
    {
        if (string.IsNullOrEmpty(iconPath))
            return string.Empty;
            
        if (iconPath.StartsWith("file:"))
        {
            var fileId = ExtractFileId(iconPath);
            return fileUrls.ContainsKey(fileId) ? fileUrls[fileId] : string.Empty;
        }
        
        return iconPath;
    }

    private int ExtractFileId(string fileReference)
    {
        if (string.IsNullOrEmpty(fileReference) || !fileReference.StartsWith("file:"))
            return 0;
        
        return int.Parse(fileReference.Substring(5));
    }

    protected override void OnPreRender(EventArgs e)
    {
        base.OnPreRender(e);
        try
        {
            // Check for cache-clearing parameter
            bool clearCache = (Request.QueryString["clearlinkscache"] != null);
            
            // Define a unique cache key based on the parameters
            var cacheKey = $"2sxcLinks_{ZoneId}_{AppId}_{GroupName.Replace(" ", "_")}";
            
            // Try to get from cache first (if not clearing cache)
            if (!clearCache) {
                var cachedData = HttpContext.Current.Cache[cacheKey] as Dictionary<string, object>;
                if (cachedData != null)
                {
                    // Use cached data and skip all processing
                    updatedLinksFiltered = cachedData["Links"] as List<Dictionary<string, object>>;
                    groupIconUrl = cachedData["GroupIcon"] as string;
                    return;
                }
            }
            
            // If not in cache, proceed with normal processing
            var dynCodeService = this.GetScopedService<IDynamicCodeService>();
            var app = dynCodeService.App(zoneId: ZoneId, appId: AppId);
            links = app.Data["Links"];
            linkGroup = app.Data["LinkGroups"].FirstOrDefault(g => g.Get<string>("GroupIdentity") == GroupName);
            groupId = linkGroup?.EntityId ?? 0;
            
            // Check if we found a valid group ID
            if (groupId == 0)
            {
                // No group found, return empty list
                return;
            }
            
            // Filter for published links in the specified group and order by OrderNumber
            linksFiltered = app.Data["Links"]
                .Where(link => link.Get("Group").ToString() == groupId.ToString() 
                              && link.Get<bool?>("IsPublished") != false)  // Include if IsPublished is null or true
                .OrderBy(link => link.Get<int?>("OrderNumber") ?? int.MaxValue); // Order by OrderNumber, treating null as highest value

            // Collect all file IDs from both links and group
            var fileIds = new List<int>();
            
            // Add file IDs from links
            fileIds.AddRange(linksFiltered
                .Where(l => !string.IsNullOrEmpty(l.Get<string>("Icon")) && l.Get<string>("Icon").StartsWith("file:"))
                .Select(l => ExtractFileId(l.Get<string>("Icon"))));
                
            // Add group icon file ID if it exists
            string groupIcon = linkGroup?.Get<string>("Icon") ?? string.Empty;
            if (!string.IsNullOrEmpty(groupIcon) && groupIcon.StartsWith("file:"))
            {
                fileIds.Add(ExtractFileId(groupIcon));
            }

            // Create a lookup dictionary of file URLs (process all file IDs at once)
            var fileUrls = new Dictionary<int, string>();
            foreach (var fileId in fileIds.Distinct())
            {
                var fileInfo = FileManager.Instance.GetFile(fileId);
                if (fileInfo != null)
                {
                    fileUrls[fileId] = FileManager.Instance.GetUrl(fileInfo);
                }
            }
            
            // Process the group icon
            groupIconUrl = GetIconUrl(groupIcon, fileUrls);

            // Use the lookup in the link processing
            foreach (var link in linksFiltered)
            {
                var icon = link.Get<string>("Icon") ?? string.Empty;
                var title = link.Get<string>("Title") ?? string.Empty;
                var url = link.Get<string>("Url") ?? "#";
                var target = link.Get<string>("Target") ?? "_self";
                var isTitleHidden = link.Get<bool?>("IsTitleHidden") ?? false;
                var cssClassName = link.Get<string>("cssClassName") ?? string.Empty;
                
                string iconUrl = GetIconUrl(icon, fileUrls);
                
                updatedLinksFiltered.Add(new Dictionary<string, object>
                {
                    { "Icon", iconUrl },
                    { "Title", title },
                    { "Url", url },
                    { "Target", target },
                    { "IsTitleHidden", isTitleHidden },
                    { "CssClassName", cssClassName }
                });
            }
            
            // Store in cache for future use if we have links
            if (updatedLinksFiltered.Count > 0)
            {
                var cacheData = new Dictionary<string, object>
                {
                    { "Links", updatedLinksFiltered },
                    { "GroupIcon", groupIconUrl }
                };
                
                // Create a cache dependency on the app data
                CacheDependency dependency = null;
                
                try {
                    // Try to create a cache key dependency based on 2sxc app data
                    string appCacheKey = string.Format("App{0}:{1}", ZoneId, AppId);
                    dependency = new CacheDependency(null, new string[] { appCacheKey });
                }
                catch {
                    // If not available, we'll use time-based expiration
                }
                
                // Add to cache with dependency (if available) or time-based expiration
                if (dependency != null) {
                    // Cache with dependency on 2sxc data
                    HttpContext.Current.Cache.Insert(
                        cacheKey,
                        cacheData,
                        dependency,
                        Cache.NoAbsoluteExpiration,
                        Cache.NoSlidingExpiration
                    );
                } else {
                    // Fallback to time-based caching
                    HttpContext.Current.Cache.Insert(
                        cacheKey,
                        cacheData,
                        null, 
                        DateTime.Now.AddMinutes(CacheDuration),
                        Cache.NoSlidingExpiration
                    );
                }
            }
        }
        catch (Exception ex)
        {
            // Log the error to the DNN Event Log
            Exceptions.LogException(ex);
        }
    }
</script>

<% if (updatedLinksFiltered.Count > 0) { %>
<div class="c-pagelinks <%= !string.IsNullOrEmpty(linkGroup?.Get<string>("CssClassName")) ? linkGroup.Get<string>("CssClassName") : "" %>">

    <% if (linkGroup != null) { %>
        <% if (linkGroup.Get<bool?>("showTitle") != false) { %>
            <h4 class="social-links-title"><%= linkGroup.Get<string>("Title") %></h4>
        <% } %>
        <% if (!string.IsNullOrEmpty(linkGroup.Get<string>("Description")) || (linkGroup.Get<bool?>("showIcon") != false && !string.IsNullOrEmpty(groupIconUrl))) { %>
            <p class="social-links-description">
                <% if (linkGroup.Get<bool?>("showIcon") != false && !string.IsNullOrEmpty(groupIconUrl)) { %>
                    <img src="<%= groupIconUrl %>" alt="Group Icon" class="bi">
                <% } %>
                <% if (!string.IsNullOrEmpty(linkGroup.Get<string>("Description"))) { %>
                    <%= linkGroup.Get<string>("Description") %>
                <% } %>
            </p>
        <% } %>
    <% } %>

    <ul class="nav c-pagelinks__list">
        <% foreach (var l in updatedLinksFiltered) { 
            // Get CSS class (combine nav-item with custom class if provided)
            string cssClass = "nav-item";
            if (!string.IsNullOrEmpty(l["CssClassName"]?.ToString())) {
                cssClass += " " + l["CssClassName"];
            }
        %>
        <li class="<%= cssClass %>">
            <% if (!string.IsNullOrEmpty(l["Icon"]?.ToString())) { %>
                <a class="nav-link icon-link" href="<%= l["Url"] %>" target="<%= l["Target"] %>">
                    <img src="<%= l["Icon"] %>" alt="<%= l["Title"] %>" class="bi">
                    <% if (!(bool)l["IsTitleHidden"]) { %>
                        <%= l["Title"] %>
                    <% } %>
                </a>
            <% } else {%>
                <a class="nav-link" href="<%= l["Url"] %>" target="<%= l["Target"] %>">
                    <% if (!(bool)l["IsTitleHidden"]) { %>
                        <%= l["Title"] %>
                    <% } %>
                </a>
            <% } %>
        </li>
        <% } %>
    </ul>
</div>
    <style>
        /* Define a reusable class */
        .svg-white {
            filter: brightness(0) invert(1);
            width: 18px;
        }
    </style>
<% } %>
