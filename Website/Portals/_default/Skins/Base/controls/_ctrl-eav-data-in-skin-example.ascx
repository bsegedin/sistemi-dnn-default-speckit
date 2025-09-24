<%@ Control language="C#" Inherits="System.Web.UI.UserControl" %>
<%@ Import Namespace="ToSic.Sxc.Services" %>

<asp:Literal ID="EavDataOutput" runat="server"></asp:Literal>

<script runat="server">
    protected override void OnPreRender(EventArgs e)
    {
        base.OnPreRender(e);

        try
        {
            // Get the current Portal ID dynamically
            int portalId = PortalSettings.Current.PortalId;

            // Retrieve the DynamicCodeService using DI
            var dynCodeService = this.GetScopedService<IDynamicCodeService>();

            // Access the 2sxc App instance (Zone ID = 2, App ID = 6)
            var app = dynCodeService.App(zoneId: 2, appId: 6);

            // Retrieve "PageLinks" content type and filter by Portal ID
            var market = app.Data["Links"].FirstOrDefault(m => m.Get<int>("PortalId") == portalId);

            // Check if a matching market exists
            //string sophus3Code = market != null ? market.Get<string>("Sophus3Code") : "";

            // Assign the Sophus3Code to the placeholder
            //Sophus3.Text = sophus3Code;
        }
        catch (Exception ex)
        {
            // Log the error to the DNN Event Log
            Exceptions.LogException(ex);

            // Check if the current user is an administrator
            bool isAdmin = UserController.Instance.GetCurrentUserInfo().IsInRole("Administrators");

            // Show error message only to Admins
            if (isAdmin)
            {
                //Sophus3.Text = "<div class=\"z-3 position-absolute alert alert-danger\" role=\"alert\">Error loading Market data. Please check logs.</div>";
            }
        }
    }
</script>


<%-- 
<%@ Register TagPrefix="base" TagName="EavTestData" src="_ctrl-eav-data-in-skin-example.ascx" %>
<base:EavTestData runat="server" /> 
 --%>
