<%@ Page Title="Change Password" Language="C#" AutoEventWireup="false" MasterPageFile="~/Site.Master"
    CodeBehind="ChangePassword.aspx.cs" Inherits="OETWeb.Account.ChangePassword" %>
<asp:Content ID="HeaderContent" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

<%
  using (var h = this.Helpers)
  {
    var toolbar = h.Toolbar();
    {
      toolbar.Helpers.HTML().Heading2("Change Password");
      var toolbarBody = toolbar.Helpers.HTMLTag("p");
      {
        toolbarBody.Style.Width = "400";
        toolbarBody.Helpers.HTML("Change Password");
      }
    }

    h.MessageHolder();

    var editor = h.With<ChangePasswordVM.ChangeDetails>((c) => c.Details);
    {
      editor.Helpers.EditorRowFor((c) => c.OldPassword);
      editor.Helpers.EditorRowFor((c) => c.NewPassword);
      editor.Helpers.EditorRowFor((c) => c.ConfirmPassword);
    }

    var button = h.Button("Ok", Singular.Web.ButtonMainStyle.Success, Singular.Web.ButtonSize.Normal, Singular.Web.FontAwesomeIcon.tick);
    {
      button.AddBinding(Singular.Web.KnockoutBindingString.click, "ChangePassword()");
    }
  }
  %>

  <script type="text/javascript">

    function ChangePassword() {
      Singular.Validation.IfValid(ViewModel.Details(), function () {
        ViewModel.CallServerMethod('ChangePassword', { Details: ViewModel.Details.Serialise() }, function (data) {
          Singular.AddMessage(data.Item1 - 1, 'Change Password', data.Item2).Fade(2000);
        }, true);
      });
    }
  </script>

</asp:Content>
