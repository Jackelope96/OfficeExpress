﻿<%@ Page Language="C#" 
    AutoEventWireup="false" 
    MasterPageFile="~/Site.Master"
    CodeBehind="Reports.aspx.cs" 
    Inherits="OETWeb.Maintenance.Reports" %>


<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<% 
  using (var h = Helpers)
  {
    var toolbar = h.Toolbar();
    {
      toolbar.Helpers.HTML().Heading2("Reports");
      var excelBtn = h.Button(Singular.Web.DefinedButtonType.Export, "Export");
      excelBtn.AddBinding(Singular.Web.KnockoutBindingString.click, "Export()");
      

      
    }

    var panel = h.Div();
    {
      panel.AddClass("Panel");
      panel.Style.Margin("10px");
      var powerbi = h.HTMLTag("<iframe width=\"1000\" height=\"800\" src=\"https://app.powerbi.com/view?r=eyJrIjoiNTk2NDY2ODUtMWViYy00NGU5LWFmOTItNmZlMWE1YjhmMzc4IiwidCI6ImM5ODcxYzlkLTdmZTYtNGIxZC1hOTdhLTIyYjE3MmI4NzJlNyIsImMiOjh9\" frameborder=\"0\" allowFullScreen=\"true\"></iframe>");
    }
  }%>

     <script type="text/javascript">

        var Export = function ()
        {
            ViewModel.CallServerMethod('ExportData', {  ShowLoadingBar: true }, function (result) {
                if (result.Success) {
                    Singular.AddMessage(3, 'Export', 'Invoices created  successfully.').Fade(2000);
                } else {
                    alert(result.ErrorText);
                }
            });
        }


     </script>


    

    </asp:Content>