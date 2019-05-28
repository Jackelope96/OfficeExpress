<%@ Page Language="C#" AutoEventWireup="false" MasterPageFile="~/Site.Master" 
    CodeBehind="Test.aspx.cs" Inherits="OETWeb.Test" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<%
  using (var h = this.Helpers)
  {
    using (var toolbar = h.Toolbar())
    {
      toolbar.Helpers.HTML().Heading2("Test Page");
    }

    h.MessageHolder();

    h.HTML().Heading1("Heading 1");
    h.HTML().Heading2("Heading 2");
    h.HTML().Heading3("Heading 3");
    h.HTML().Heading4("Heading 4");
    h.HTML().Heading5("Heading 5");
  }
%>
</asp:Content>
