<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="OETWeb.Account.Home" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
	<link href="../Styles/dashboard.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

	<h2>Welcome to Office Express Tuck Shop
	</h2>


	<%if (OETLib.Security.OETWebSecurity.HasAuthenticatedUser())
		{ %>
	<div>
		Users will see this text when logged in.
	</div>
	<%}%>

	<%if (!OETLib.Security.OETWebSecurity.HasAuthenticatedUser())
		{%>
	<div>
		Users will see this text when logged out.
	</div>
	<%}%>
</asp:Content>
