<%@ Control Language="C#" AutoEventWireup="false" Explicit="True" Inherits="DotNetNuke.UI.Skins.Skin" %>

<%@ Import Namespace="DotNetNuke.Security.Permissions" %>
<%@ Import Namespace="DotNetNuke.Services.Localization" %>
<%@ Import Namespace="TabInfo=DotNetNuke.Entities.Tabs.TabInfo" %>
<%@ Import Namespace="BaseTheme" %>

<%@ Register TagPrefix="asp" Namespace="System.Web.UI" Assembly="System.Web" %>
<%@ Register TagPrefix="dnn" TagName="LOGO" Src="~/Admin/Skins/Logo.ascx" %>
<%@ Register TagPrefix="dnn" TagName="LOGIN" Src="~/Admin/Skins/Login.ascx" %>
<%@ Register TagPrefix="dnn" TagName="SEARCH" Src="~/Admin/Skins/Search.ascx" %>
<%@ Register TagPrefix="dnn" TagName="MENU" Src="~/DesktopModules/DDRMenu/Menu.ascx" %>
<%@ Register TagPrefix="dnn" TagName="COPYRIGHT" Src="~/Admin/Skins/Copyright.ascx" %>
<%@ Register TagPrefix="dnn" Namespace="DotNetNuke.Web.DDRMenu.TemplateEngine" Assembly="DotNetNuke.Web.DDRMenu" %>
<%@ Register TagPrefix="dnn" Namespace="DotNetNuke.Web.Client.ClientResourceManagement" Assembly="DotNetNuke.Web.Client" %>
<%@ Register TagPrefix="nms" TagName="SxcPageLinks" Src="_ctrl-2sxc-links.ascx" %>
<%@ Register TagPrefix="tosic" TagName="SxcQuickEdit" Src="_ctrl-2sxc-quickedit.ascx" %>

<script>
    const THEME_KEY = 'preferredTheme';
    // Set the initial color mode based on localStorage or system preference
    (function () {
        var t = localStorage.getItem(THEME_KEY) || (window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light');
        document.documentElement.setAttribute('data-bs-theme', t);
    })();
</script>

<tosic:SxcQuickEdit runat="server" />

<a class="visually-hidden-focusable" rel="nofollow" href="#page-main-content"><%= ThemeHelpers.LocalizeString("SkipLink.MainContent",this) %></a>
<h1 class="visually-hidden"><%= ThemeHelpers.PageName %></h1>

<header class="navbar navbar-expand-lg navbar-light">
    <div class="<%= headerContainerClass %>">
        <a class="navbar-brand" href="<%=ThemeHelpers.GetHomePageURL()%>">
            <img src="<%=ThemeHelpers.GetPortalLogo()%>" alt="<%= PortalSettings.PortalName %>" width="180" class="d-inline-block align-text-top" />
            <span><%= PortalSettings.PortalName %></span>
        </a>
        <div class="d-block d-lg-none ms-auto me-2">
            <dnn:LOGIN ID="dnnLoginMobile" CssClass="btn btn-primary" runat="server" LegacyMode="false" />
        </div>
        <button class="navbar-toggler" type="button" data-bs-toggle="offcanvas" data-bs-target="#navbarOffcanvas" aria-controls="navbarOffcanvas" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="offcanvas offcanvas-start navbar-collapse" id="navbarOffcanvas" tabindex="-1" aria-labelledby="offcanvasNavbarLabel">
            <div class="offcanvas-header">
                <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
            </div>
            <div class="desktop-body offcanvas-body pt-0 align-items-center">
                <dnn:MENU ID="mainMenu" MenuStyle="nav/main" runat="server" />
            </div>
        </div>
        <div class="form-check form-switch d-flex align-items-center me-4">
            <input class="form-check-input me-2" type="checkbox" id="themeSwitch">
            <label class="form-check-label theme-toggle-label" for="themeSwitch">
                <span id="themeIcon" class="theme-icon">🌞</span>
            </label>
        </div>
        <dnn:SEARCH runat="server" ID="dnnSearch" ShowSite="False" ShowWeb="False" CssClass="btn btn-secondary" />
        <div class="d-none d-lg-block ms-2">
            <dnn:LOGIN ID="dnnLogin" CssClass="btn btn-primary" runat="server" LegacyMode="false" />
        </div>
    </div>
</header>

<main id="page-main-content" role="document" class="page-main-content <%= bodyContainerClass %>">

    <div id="ContentPane" runat="server" containertype="G" containername="Base" containersrc="default.ascx"></div>

    <% if (showSplitPanes39)
    { %>
        <div class="l-content row">
            <div class="col-12 col-lg-3">
                <dnn:MENU ID="asideMenu" MenuStyle="nav/aside" runat="server" />
                <div id="LeftPane" class="left-pane" runat="server" containertype="G" containername="Base" containersrc="default.ascx"></div>
            </div>
            <div class="col-12 col-lg-9">
                <div id="RightPane" class="right-pane" runat="server" containertype="G" containername="Base" containersrc="default.ascx"></div>
            </div>
        </div>
    <% } %>

    <% if (showSplitPanes75)
    { %>

    <div class="l-content row">
        <div class="col-12 col-lg-7">
            <img src="<%= ThemeHelpers.GetIconFileLarge(1200,800) %>" class="img-fluid" />
        </div>
        <div class="col-12 col-lg-5">
            <div id="NarrowPane" class="right-pane" runat="server" containertype="G" containername="Base" containersrc="default.ascx"></div>
        </div>
    </div>
    <% } %>

    <a id="theme-to-top" href="#" title="<%= ThemeHelpers.LocalizeString("ToTop.Text",this) %>" rel="nofollow" class="d-flex align-items-center justify-content-center rounded-circle">
        <img alt="<%= ThemeHelpers.LocalizeString("ToTop.Text",this) %>" class="logo img-fluid" src="/Portals/_default/skins/base/images/arrow-to-top.svg" width="60" height="60">
    </a>
</main>

<footer class="footer">
    <div class="<%= footerContainerClass %> d-flex flex-wrap justify-content-between align-items-center py-3 my-4">
        <div class="col-lg-6 d-lg-flex align-items-center">
            <a class="footer-brand me-4 mb-2 mb-lg-0" href="<%=ThemeHelpers.GetHomePageURL()%>">
                <img src="<%=ThemeHelpers.GetPortalLogo()%>" alt="<%= PortalSettings.PortalName %>" width="100" class="footer-logo d-inline-block align-text-top" />
            </a>
            <nms:SxcPageLinks runat="server" id="PolicyLinks" GroupName="portal-policy-links" />
        </div>
        <div class="col-lg-6 d-flex justify-content-center">
            <nms:SxcPageLinks runat="server" id="SocialLinks" GroupName="social-links"/>
        </div>
    </div>
    <div class="l-copyright d-flex justify-content-center border-top">
        <dnn:COPYRIGHT ID="dnnCopyright" runat="server" CssClass="copyright-box pt-3" />
    </div>
</footer>

<dnn:DnnCssInclude runat="server" FilePath="dist/styles.css" Priority="98" PathNameAlias="SkinPath" HtmlAttributesAsString="rel:'stylesheet preload', as:'style'" />

<dnn:DnnJsInclude runat="server" FilePath="dist/lib/bootstrap.bundle.min.js" ForceProvider="DnnFormBottomProvider" Priority="100" PathNameAlias="SkinPath" HtmlAttributesAsString="defer, async" />
<dnn:DnnJsInclude runat="server" FilePath="dist/scripts.js" ForceProvider="DnnFormBottomProvider" Priority="130" PathNameAlias="SkinPath" HtmlAttributesAsString="defer, async" />

<dnn:DnnCssExclude runat="server" Name="dnndefault" />


<script runat="server">
    ThemeHelpers themeHelpers = new ThemeHelpers();

    protected override void OnLoad(EventArgs e)
    {
        base.OnLoad(e);

        ThemeHelpers.AttachCustomHeader(this.Page, "<meta name='viewport' content='width=device-width, initial-scale=1, shrink-to-fit=no' />");
        ThemeHelpers.SetMainPageData(this.Page);

        // Set NodeSelector attributes for NAV SkinObjects
        mainMenu.NodeSelector = ThemeHelpers.MainNavNodeSelector;
        asideMenu.NodeSelector = ThemeHelpers.SectionPageId.ToString(); 

        // Set various FavIcon and Icon headers according to best practices
        // The next line is disabled by default, because it requires RazorBlade to be installed.
        // How to install RazorBlade 3: https://azing.org/dnn-community/r/zbh8JC5T
        // How to create best-practice FavIcons: https://azing.org/dnn-community/r/UhgWJbxh
        // ToSic.Razor.Blade.HtmlPage.AddIconSet(SkinPath + "favicon.png");
    }

    protected override void OnPreRender(EventArgs e)
    {
        base.OnPreRender(e);
        ThemeHelpers.NormalizePageTitle(this.Page);
        ThemeHelpers.AddClassToHtmlTag(this.Page, "Body", ThemeHelpers.GetCssClassesForBody(layoutType));
    }
</script>

<script>
    const htmlEl = document.documentElement;
    const switchInput = document.getElementById('themeSwitch');
    const themeIcon = document.getElementById('themeIcon');

    function setTheme(theme) {
      htmlEl.setAttribute('data-bs-theme', theme);
      localStorage.setItem(THEME_KEY, theme);
      updateUI(theme);
    }

    function updateUI(theme) {
      switchInput.checked = theme === 'dark';
      themeIcon.textContent = theme === 'dark' ? '🌙' : '🌞';
    }

    // Initialize color mode on load
    document.addEventListener('DOMContentLoaded', () => {
      const savedTheme = localStorage.getItem(THEME_KEY);
      const prefersDark = window.matchMedia('(prefers-color-scheme: dark)').matches;
      const theme = savedTheme || (prefersDark ? 'dark' : 'light');
      setTheme(theme);
    });

    // Toggle color mode switch logic
    switchInput.addEventListener('change', () => {
      const theme = switchInput.checked ? 'dark' : 'light';
      setTheme(theme);
    });
</script>
