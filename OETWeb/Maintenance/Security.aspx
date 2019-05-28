<%@ Page Title="Security" Language="C#" AutoEventWireup="false" MasterPageFile="~/Site.Master"
	CodeBehind="Security.aspx.cs" Inherits="OETWeb.Maintenance.Security" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

	<%
		using (var h = Helpers)
		{
			h.Control(new Singular.Web.Security.SecurityControl());
		}
	%>

	<script type="text/javascript">
		Singular.OnPageLoad(function () {
			toggleMaintenanceSubMenu();
			$("#maintenance3").addClass("activeSub");
			$("#Undo").remove();
		});

	</script>

</asp:Content>
