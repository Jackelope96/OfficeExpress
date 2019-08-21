<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Invoices.aspx.cs" MasterPageFile="~/Site.Master" Inherits="OETWeb.Maintenance.Invoices" %>




<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

  <% 
    using (var h = Helpers)
    {
      var toolbar = h.Toolbar();
      {
        toolbar.Helpers.HTML().Heading2("Invoices");
        var excelBtn = h.Button(Singular.Web.DefinedButtonType.Export, "Export");
        excelBtn.AddBinding(Singular.Web.KnockoutBindingString.click, "Export()");

      }
    }

  %>

   <script type="text/javascript">

    var Export = function () {
      ViewModel.CallServerMethod('ExportData', { ShowLoadingBar: true }, function (result) {
        if (result.Success) {
          var date = new Date();
          var blob = new Blob([s2ab(atob(result.Data))], {
            type: ''
          });
          const url = URL.createObjectURL(blob);
          const a = document.createElement('a');
          a.style.display = 'none';
          a.href = url;
          // the filename you want
          a.download = date+'_TuckshopExpress.xlsx';
          document.body.appendChild(a);
          a.click();
          window.URL.revokeObjectURL(url);

          Singular.AddMessage(3, 'Export', 'Invoices created  successfully.').Fade(2000);
        } else {
          alert(result.ErrorText);
        }
      });
    }

    function s2ab(s) {
      var buf = new ArrayBuffer(s.length);
      var view = new Uint8Array(buf);
      for (var i = 0; i != s.length; ++i) view[i] = s.charCodeAt(i) & 0xFF;
      return buf;
    }


  </script>

  </asp:Content>