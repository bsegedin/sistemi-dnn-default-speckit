<%@ Control language="C#" AutoEventWireup="false" Explicit="True" Inherits="DotNetNuke.UI.Containers.Container" %>
<%-- The ID contains the module-id, which lets content inside add CSS affecting this --%>
<div id="module-<%= ModuleConfiguration.ModuleID %>" class="l-mc">
  <div id="ContentPane" runat="server" class="l-mc__content"></div>
</div>
