using System;
using DotNetNuke.Services.Localization;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using DotNetNuke.Entities.Portals;
using DotNetNuke.Entities.Tabs;
using System.Linq;
using DotNetNuke.Security.Permissions;
using Dnn.PersonaBar.Themes.Components;
using DotNetNuke.Common;
using System.Web;

namespace BaseTheme
{
    public class ThemeHelpers
    {
        // Sets the Node selectors for the main desktop navigation -> determin which pages are laoded and included in the navigation 
        //* -> means the root level, 0 -> means skip the nav-level-0, 1 -> means the nav-level-1
        public static string MainNavNodeSelector { get; set; } = "*,0,6";
        public static bool IsHome { get; private set; }
        public static string PageName { get; private set; }
        public static int ParentPageId { get; private set; }
        public static int SectionPageId { get; private set; }
        private static string _resPath;

        /// <summary>
        /// Used to get portal home page id
        /// </summary>
        public static string GetHomePageURL()
        {
            var homeTab = TabController.Instance.GetTab(PortalSettings.Current.HomeTabId, PortalSettings.Current.PortalId, false);
            return homeTab != null ? homeTab.FullUrl : string.Empty;
        }


        /// <summary>
        /// Used to get important context data and prepare it to easy use in DNN skin
        /// </summary>
        public static void SetMainPageData(Page page)
        {
            var portal = PortalSettings.Current;
            IsHome = portal.HomeTabId == portal.ActiveTab.TabID;

            if (IsHome)
            {
                PageName = portal.PortalName; // Site name
            }
            else
            {
                PageName = portal.ActiveTab.TabName; // Page name
            }

            // Check if the current page has a parent page
            if (portal.ActiveTab.ParentId > -1)
            {
                ParentPageId = portal.ActiveTab.ParentId;
            }
            else
            {
                ParentPageId = -1; // No parent page
            }

            // Set SectionPageId to the root page of the section
            var tab = portal.ActiveTab;
            var rootTab = tab.BreadCrumbs[0] as DotNetNuke.Entities.Tabs.TabInfo;
            if (rootTab != null)
            {
                SectionPageId = rootTab.TabID;
            }
            else
            {
                SectionPageId = -1; // No section page
            }
        }


        /// <summary>
        /// Change DNN generated page title in more appropriate SEO friendly format
        /// </summary>
        public static void NormalizePageTitle(Page page)
        {
            const string separator = " | ";
            const int depth = 5;
            const bool includePortalName = true;

            if (String.IsNullOrEmpty(PortalSettings.Current.ActiveTab.Title))
            {
                page.Title = String.Join(separator, PortalSettings.Current.ActiveTab.BreadCrumbs.Cast<TabInfo>()
                    .Reverse().Take(depth).Select(p => p.TabName).Distinct().ToArray()) +
                    (includePortalName ? separator + PortalSettings.Current.PortalName : "");
            }
        }

        /// <summary>
        /// Take localisation value from theme resource file and return it
        /// </summary>
        public static string LocalizeString(string key, Control control)
        {
            return Localization.GetString(key, ResourceFilePath(control));
        }

        /// <summary>
        /// Used to get the path to the resource file for the theme
        /// </summary>
        public static string ResourceFilePath(Control control)
        {
            return _resPath ?? (_resPath = Localization.GetResourceFile(control, System.IO.Path.GetFileName("/Portals/_default/Skins/Base/App_LocalResources/SharedResources.resx")));
        }

        /// <summary>
        /// Used to create custom header tag on the page
        /// </summary>
        public static void AttachCustomHeader(Page page, string customHeader)
        {
            HtmlHead htmlHead = (HtmlHead)page.FindControl("Head");
            if (htmlHead != null)
            {
                htmlHead.Controls.Add(new LiteralControl(customHeader));
            }
        }

        /// <summary>
        /// Used to create HTML link tag for CSS on the page head and avoid standard DNN mechanism for CSS bundling
        /// </summary>
        public static void AttachExternalCSS(Page page, string CSSPath)
        {
            AttachCustomHeader(page, "<link type='text/css' rel='stylesheet' href='" + CSSPath + "' />");
        }

        /// <summary>
        /// Used to create HTML script tag on the page head and avoid standard DNN mechanism for JS bundling
        /// </summary>
        public static void AttachExternalJS(Page page, string JSPath)
        {
            AttachCustomHeader(page, "<script type='text/javascript' src='" + JSPath + "'></scr" + "ipt>");
        }

        /// <summary>
        /// For given TabInfo object, check if it has any children that are visible and user has permission to view
        /// </summary>
        public static bool HasChildrenInMenu(TabInfo tab)
        {
            return tab.HasChildren && TabController.GetTabsByParent(tab.TabID, tab.PortalID).Any(t => t.IsVisible && !t.IsDeleted && TabPermissionController.CanViewPage(t));
        }

        /// <summary>
        /// Generate CSS classes based on CMS data for the body tag
        /// </summary>
        public static string GetCssClassesForBody(string layout)
        {
            // Get objects we want to inform about in the CSS classes
            var portal = DotNetNuke.Entities.Portals.PortalSettings.Current;
            var tab = portal.ActiveTab;
            var rootTab = tab.BreadCrumbs[0] as DotNetNuke.Entities.Tabs.TabInfo;
            var neutralRoot = rootTab.IsDefaultLanguage || rootTab.IsNeutralCulture ? rootTab : rootTab.DefaultLanguageTab;

            return LayoutVariationClasses(layout)
                + PageAndPortalClasses(portal, rootTab)
                + LanguageClasses(portal)
                + CurrentPageClasses(portal, tab)
                + UserRoleClasses(portal);
        }


        /// <summary>
        /// CSS class for theme layout variation
        /// </summary>
        private static string LayoutVariationClasses(string layout)
        {
            if (string.IsNullOrEmpty(layout)) layout = "Default";
            // Convert layout name to lowercase and replace spaces with hyphens
            string formattedLayout = layout.ToLower().Replace(" ", "-");
            return "theme-base theme-variation-" + formattedLayout + " ";
        }


        /// <summary>
        /// CSS classes which tell the skin what portal and site root page is used
        /// </summary>
        private static string PageAndPortalClasses(PortalSettings portal, DotNetNuke.Entities.Tabs.TabInfo rootTab)
        {
            return "site-" + portal.PortalId
                + " section-root-" + rootTab.TabID + " ";
        }


        /// <summary>
        /// CSS classes which tell the skin what language is used
        /// </summary>
        private static string LanguageClasses(PortalSettings portal)
        {
            var currentLang = System.Threading.Thread.CurrentThread.CurrentCulture.TwoLetterISOLanguageName.ToLower();
            return "lang-" + currentLang + " ";
        }


        /// <summary>
        /// CSS classes which tell the skin about the current page
        /// </summary>
        private static string CurrentPageClasses(PortalSettings portal, DotNetNuke.Entities.Tabs.TabInfo tab)
        {
            return "page-" + tab.TabID + " "
                + (portal.ActiveTab.ParentId > -1 ? "page-parent-" + portal.ActiveTab.ParentId + " " : "")
                + (portal.HomeTabId == portal.ActiveTab.TabID ? "page-is-home " : "")
                + "nav-level-" + (tab.Level + 1) + " ";
        }


        /// <summary>
        /// List of CSS classes which get list of user roles and authentication from context and give it to the skin.
        /// </summary>
        private static string UserRoleClasses(PortalSettings portal)
        {
            var user = System.Web.HttpContext.Current.User;
            var isAuthenticated = user.Identity.IsAuthenticated;
            var hasEditPermissions = DotNetNuke.Security.Permissions.TabPermissionController.HasTabPermission("EDIT");

            var baseClasses = (isAuthenticated ? "user-authenticated " : "user-public ") +
                              (hasEditPermissions ? "role-can-edit " : "");

            var userInfo = DotNetNuke.Entities.Users.UserController.GetUserById(portal.PortalId, portal.UserId);
            if (userInfo == null)
            {
                return baseClasses;
            }

            var roles = new[] { "Superusers", "Administrators", "Content Editors", "Content Managers", "Subscribers" };

            var roleClasses = userInfo.Roles != null
				? roles.Where(role => userInfo.Roles.Contains(role))
					   .Select(role => "role-" + role.ToLower().Replace(" ", "_"))
					   .ToArray()
				: new string[0];

            return baseClasses + string.Join(" ", roleClasses) + " ";
        }



        /// <summary>
        /// Generate DNN portal Logo URL from portal settings
        /// </summary>
        public static string GetPortalLogo()
        {
            // Try to get the current PortalSettings from HttpContext.
            PortalSettings ps = HttpContext.Current?.Items["PortalSettings"] as PortalSettings;
            if (ps == null)
            {
                // Fallback: return a placeholder
                return "https://placehold.co/250x70?text=No+PortalSettings";
            }

            // Fetch the portal info for the current portal.
            PortalInfo portal = new PortalController().GetPortal(ps.PortalId);
            if (portal == null || string.IsNullOrEmpty(portal.LogoFile))
            {
                // Fallback: return a placeholder
                return "https://placehold.co/250x70?text=No+Logo";
            }

            // portal.LogoFile might be something like "nms-logo.svg" or already "Portals/0/nms-logo.svg".
            // We ensure it has "Portals/{PortalId}/" if needed.
            string logoFile = portal.LogoFile.TrimStart('/', '\\'); // Remove any leading slashes just in case.

            // If it doesn't already start with "Portals/", prepend "Portals/{PortalId}/".
            if (!logoFile.StartsWith("Portals/", StringComparison.OrdinalIgnoreCase))
            {
                logoFile = $"Portals/{ps.PortalId}/{logoFile}";
            }

            // Return a site-root-relative URL with a leading slash, using forward slashes.
            return "/" + logoFile.Replace("\\", "/");
        }


        /// <summary>
        /// Add CSS class to HTML element in DNN. This method have performance issues so it have special handling for body tag. For other tags use it with performance in mind.
        /// </summary>
        public static void AddClassToHtmlTag(Page page, string tagId, string cssClassName)
        {
            // For Body specifically, use a more direct approach
            if (tagId == "Body")
            {
                // In DNN, we can directly manipulate the page's form attribute
                try
                {
                    // Get the HtmlForm control which is typically the parent of the body content
                    HtmlForm form = page.Form;
                    if (form != null)
                    {
                        HtmlGenericControl body = form.Parent as HtmlGenericControl;
                        if (body != null && body.TagName.Equals("body", StringComparison.OrdinalIgnoreCase))
                        {
                            // Check if class attribute exists
                            if (body.Attributes["class"] == null)
                            {
                                body.Attributes["class"] = cssClassName;
                            }
                            else if (!body.Attributes["class"].Contains(cssClassName))
                            {
                                body.Attributes["class"] += " " + cssClassName;
                            }
                            return; // Successfully added class
                        }
                    }
                }
                catch (Exception ex)
                {
                    // Log the error
                    DotNetNuke.Services.Exceptions.Exceptions.LogException(
                        new Exception("Error adding class to body element", ex));
                }
            }
            else
            {
                // Standard approach for other controls
                Control control = page.FindControl(tagId);
                if (control != null && control is HtmlGenericControl htmlControl)
                {
                    // Check if class attribute exists
                    if (htmlControl.Attributes["class"] == null)
                    {
                        htmlControl.Attributes["class"] = cssClassName;
                    }
                    else if (!htmlControl.Attributes["class"].Contains(cssClassName))
                    {
                        htmlControl.Attributes["class"] += " " + cssClassName;
                    }
                }
            }
        }


        /// <summary>
        /// Retrieves the IconFileLarge data for the current active tab in the DNN portal
        /// and appends ImageFlow parameters (w, h, mode, crop) to the URL.
        /// Removes the "ver=" parameter from the URL if present.
        /// </summary>
        /// <param name="w">Width of the image.</param>
        /// <param name="h">Height of the image.</param>
        /// <param name="mode">Resize mode (e.g., "pad", "crop").</param>
        /// <param name="crop">Crop region (e.g., "center").</param>
        /// <returns>URL of the large icon file with ImageFlow parameters.</returns>
        public static string GetIconFileLarge(int w, int h, string mode = "crop", string crop = "center")
        {
            // Get the current portal settings
            var portal = PortalSettings.Current;

            // Get the active tab (current page)
            var activeTab = portal.ActiveTab;

            // Check if IconFileLarge is set for the active tab
            if (!string.IsNullOrEmpty(activeTab.IconFileLarge))
            {
                // Ensure the path is site-root-relative
                string iconUrl = activeTab.IconFileLarge.StartsWith("~")
                    ? Globals.ResolveUrl(activeTab.IconFileLarge)
                    : activeTab.IconFileLarge;

                // Remove "ver=" parameter if it exists
                int verIndex = iconUrl.IndexOf("?ver=", StringComparison.OrdinalIgnoreCase);
                if (verIndex > -1)
                {
                    iconUrl = iconUrl.Substring(0, verIndex);
                }

                // Append ImageFlow parameters to the URL
                string queryString = $"?w={w}&h={h}&mode={mode}&crop={crop}";
                return iconUrl + queryString;
            }

            // Fallback: return a placeholder or empty string if no IconFileLarge is set
            return $"https://picsum.photos/{w}/{h}?mode={mode}&crop={crop}"; // Adjust the fallback path as needed
        }
    }
}
