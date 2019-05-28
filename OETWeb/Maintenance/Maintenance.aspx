<%@ Page Title="Maintenance" Language="C#" AutoEventWireup="false" MasterPageFile="~/Site.Master"
	CodeBehind="Maintenance.aspx.cs" Inherits="OETWeb.Maintenance.Maintenance" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
	<!-- CSS -->
	<link href="../Styles/maintenance.css" rel="stylesheet" />

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

	<% 
		using (var h = Helpers)
		{
			h.Control(new Singular.Web.MaintenanceHelpers.MaintenanceStateControl());
		}

	%>
	<script type="text/javascript">
		Singular.OnPageLoad(function () {
			toggleMaintenanceSubMenu();
			$("#maintenance1").addClass("activeSub");

		});
	</script>

</asp:Content>
