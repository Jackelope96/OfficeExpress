<%@ Page Title="System Settings" Language="C#" AutoEventWireup="false" MasterPageFile="~/Site.Master"
    CodeBehind="SystemSettings.aspx.cs" Inherits="OETWeb.Maintenance.SystemSettings" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
  <style type="text/css">
    div.row label {
      width: 150px;
    }
    input[type=text] {
      width: 200px;
    }
  </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<%
  using (var h = Helpers)
  {
    h.Control(new Singular.Web.SystemSettings.SystemSettingsControl(true));
  }
%>
  <script type="text/javascript">
  	Singular.OnPageLoad(function () {
  		toggleMaintenanceSubMenu();
  		$("#maintenance4").addClass("activeSub");
  		$("#Undo").remove();
  	});
		</script>

</asp:Content>
