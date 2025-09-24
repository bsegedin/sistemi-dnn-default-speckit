<%@ Control Language="C#" AutoEventWireup="true" %>

<script runat="server">
    public string Languages { get; set; }

    protected string[] LanguagesArray
    {
        get { return Languages.Split(','); }
    }

    DotNetNuke.UI.Skins.Controls.LanguageTokenReplace LanguageTokenReplace = new DotNetNuke.UI.Skins.Controls.LanguageTokenReplace();

    string GetCurrentTabUrlForLanguage(string language)
    {
        LanguageTokenReplace.Language = language;
        return LanguageTokenReplace.ReplaceEnvironmentTokens("[URL]");
    }

    bool ShowLanguageSwitchForLanguage(string language)
    {
        var locale = new LocaleController().GetLocale(PortalSettings.Current.PortalId, language);
        var permissionProvider = new DotNetNuke.Security.Permissions.PermissionProvider();
        var defaultLanguageTab = PortalSettings.Current.ActiveTab.IsDefaultLanguage ? PortalSettings.Current.ActiveTab : PortalSettings.Current.ActiveTab.DefaultLanguageTab;
        var tabForLanguage = new TabController().GetTabByCulture(defaultLanguageTab.TabID, PortalSettings.Current.PortalId, locale);

        if (tabForLanguage != null && permissionProvider.HasTabPermission(permissionProvider.GetTabPermissions(tabForLanguage.TabID, PortalSettings.Current.PortalId), "VIEW"))
            return true;

        return false;
    }

</script>


<div class="dropdown language-wrapper d-lg-flex">
    <button class="dropdown-toggle language-button d-none d-lg-block" type="button" id="dropdownLanguage" data-bs-toggle="dropdown" aria-expanded="false">
        <?xml version="1.0" encoding="UTF-8" standalone="no"?>
        <!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
        <svg width="100%" height="100%" viewBox="0 0 30 30" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" xml:space="preserve" xmlns:serif="http://www.serif.com/" style="fill-rule:evenodd;clip-rule:evenodd;stroke-linejoin:round;stroke-miterlimit:2;">
            <g id="global_icon" transform="matrix(1,0,0,1,-1686.01,-25.0194)">
                <path d="M1714.68,33.9L1714.6,33.737C1711.16,26.242 1702.28,22.945 1694.76,26.379C1687.24,29.84 1683.94,38.724 1687.37,46.246C1690.83,53.768 1699.72,57.065 1707.24,53.604C1714.71,50.198 1718.03,41.423 1714.68,33.9ZM1715.17,39.596L1711.76,39.596C1711.68,37.416 1711.19,35.263 1710.24,33.274C1711.55,33.574 1712.83,33.982 1714.05,34.5C1714.74,36.108 1715.12,37.852 1715.17,39.596ZM1696.5,39.596L1691.05,39.596C1691.13,37.307 1691.73,35.073 1692.8,33.028C1694.32,32.728 1695.88,32.511 1697.43,32.374C1696.86,34.745 1696.56,37.171 1696.5,39.596ZM1698.27,32.32C1699.17,32.265 1700.07,32.238 1701,32.238C1701.93,32.238 1702.83,32.265 1703.73,32.32C1704.32,34.691 1704.65,37.144 1704.68,39.596L1697.32,39.596C1697.38,37.144 1697.67,34.691 1698.27,32.32ZM1696.5,40.414C1696.53,42.839 1696.86,45.265 1697.43,47.636C1695.88,47.5 1694.32,47.281 1692.8,46.981C1691.73,44.938 1691.13,42.703 1691.05,40.414L1696.5,40.414ZM1697.32,40.414L1704.68,40.414C1704.65,42.867 1704.32,45.32 1703.73,47.691C1702.83,47.745 1701.93,47.772 1701,47.772C1700.07,47.772 1699.17,47.745 1698.27,47.691C1697.67,45.32 1697.38,42.867 1697.32,40.414ZM1705.5,40.414L1710.95,40.414C1710.87,42.703 1710.27,44.938 1709.2,46.981C1707.68,47.281 1706.12,47.5 1704.57,47.636C1705.14,45.265 1705.44,42.839 1705.5,40.414ZM1705.5,39.596C1705.47,37.171 1705.14,34.745 1704.57,32.374C1706.12,32.484 1707.68,32.702 1709.2,33.028C1710.27,35.073 1710.87,37.307 1710.95,39.596L1705.5,39.596ZM1713.54,33.41C1712.31,32.974 1711.03,32.592 1709.75,32.32C1708.28,29.595 1706.2,27.469 1704.27,26.215C1708.25,27.169 1711.63,29.785 1713.54,33.41ZM1708.68,32.102C1707.24,31.829 1705.8,31.666 1704.35,31.557C1704.13,30.767 1703.91,30.085 1703.75,29.567C1703.64,29.24 1702.93,27.278 1702.14,26.051C1704.19,26.706 1706.83,28.968 1708.68,32.102ZM1701,25.861C1701.49,26.27 1702.61,28.368 1703.48,31.475C1702.66,31.42 1701.82,31.393 1701,31.393C1700.15,31.393 1699.34,31.42 1698.52,31.475C1699.39,28.396 1700.51,26.27 1701,25.861ZM1698.27,29.567C1698.08,30.085 1697.87,30.767 1697.67,31.557C1696.23,31.666 1694.79,31.857 1693.34,32.102C1695.19,28.968 1697.84,26.706 1699.88,26.025C1699.06,27.278 1698.38,29.24 1698.27,29.567ZM1697.7,26.215C1695.77,27.469 1693.72,29.595 1692.25,32.32C1690.97,32.592 1689.72,32.947 1688.46,33.41C1690.37,29.785 1693.75,27.169 1697.7,26.215ZM1687.94,34.473C1689.17,33.982 1690.45,33.574 1691.76,33.246C1690.83,35.236 1690.32,37.389 1690.23,39.569L1686.83,39.569C1686.88,37.825 1687.26,36.108 1687.94,34.473ZM1686.83,40.414L1690.23,40.414C1690.32,42.594 1690.81,44.747 1691.76,46.737C1690.45,46.437 1689.17,46.028 1687.94,45.51C1687.26,43.902 1686.88,42.158 1686.83,40.414ZM1688.46,46.601C1689.69,47.037 1690.97,47.418 1692.25,47.691C1693.72,50.416 1695.79,52.541 1697.73,53.795C1693.75,52.841 1690.37,50.225 1688.46,46.601ZM1693.31,47.908C1694.76,48.181 1696.2,48.372 1697.65,48.454C1697.87,49.244 1698.08,49.925 1698.25,50.443C1698.36,50.77 1699.06,52.733 1699.86,53.959C1697.81,53.305 1695.17,51.043 1693.31,47.908ZM1701,54.15C1700.51,53.741 1699.39,51.642 1698.52,48.535C1699.34,48.59 1700.18,48.617 1701,48.617C1701.84,48.617 1702.66,48.59 1703.48,48.535C1702.61,51.615 1701.49,53.741 1701,54.15ZM1703.73,50.443C1703.91,49.925 1704.13,49.244 1704.32,48.454C1705.77,48.345 1707.21,48.154 1708.66,47.908C1706.8,51.043 1704.16,53.305 1702.12,53.986C1702.93,52.733 1703.62,50.77 1703.73,50.443ZM1704.3,53.795C1706.23,52.541 1708.3,50.416 1709.78,47.691C1711.06,47.418 1712.31,47.064 1713.56,46.601C1711.63,50.225 1708.25,52.841 1704.3,53.795ZM1714.05,45.537C1712.83,46.028 1711.55,46.437 1710.24,46.764C1711.16,44.774 1711.68,42.621 1711.76,40.441L1715.17,40.441C1715.12,42.158 1714.74,43.902 1714.05,45.537Z" style="fill:rgb(11,69,127);fill-rule:nonzero;"/>
            </g>
        </svg>
    </button>
    <ul id="theme-page-language" class="dropdown-menu dropdown-menu-end d-none d-lg-block" aria-labelledby="dropdownLanguage">
        <% foreach (var language in LanguagesArray) { %>
            <% var lang = language.Split(':'); %>
            <% if (ShowLanguageSwitchForLanguage(lang[0]))
                { %>
                <li class="<%= "nav-" + lang[0].ToLower() %><%= lang[0].ToLower() == CultureInfo.CurrentCulture.ToString().ToLower() ? " active" : "" %>">
                    <a href="<%= GetCurrentTabUrlForLanguage(lang[0]) %>"><%= lang[1] %></a>
                </li>
            <% } %>
        <% } %>
    </ul>
    <div class="active-language">
        <% foreach (var language in LanguagesArray) { %>
            <% var lang = language.Split(':'); %>
            <% if (ShowLanguageSwitchForLanguage(lang[0]))
                { %>
                <div class="<%= "nav-" + lang[0].ToLower() %><%= lang[0].ToLower() == CultureInfo.CurrentCulture.ToString().ToLower() ? " active" : "" %>">
                    <a href="<%= GetCurrentTabUrlForLanguage(lang[0]) %>"><%= lang[1] %></a>
                </div>
            <% } %>
        <% } %>
    </div>
</div>







