<%@ Page Language="C#"
    AutoEventWireup="false"
    MasterPageFile="~/Site.Master"
    CodeBehind="Users.aspx.cs"
    Inherits="OETWeb.Maintenance.Users" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <%
        using (var h = Helpers)
        {
            var toolbar = h.Toolbar();
            {
                toolbar.Helpers.HTML().Heading2("Manage Users");


                var FilterDiv = toolbar.Helpers.DivC("row col-md-12");
                {
                    var FilterDiv1 = FilterDiv.Helpers.DivC("row col-md-6");
                    {

                    }

                    var FilterDiv2 = toolbar.Helpers.DivC("row col-md-6");
                    {
                        if (Singular.Security.Security.HasAccess("Security.Manage Users"))
                        {
                            var newUserButton = FilterDiv2.Helpers.Button("New User", Singular.Web.ButtonMainStyle.NoStyle, Singular.Web.ButtonSize.Normal, Singular.Web.FontAwesomeIcon.userPlus);
                            newUserButton.AddClass("custom_BbtnMd");
                            newUserButton.Style.Margin("20px");
                            newUserButton.AddBinding(Singular.Web.KnockoutBindingString.click, "EditUser()");
                        }
                    }

                }

            }

            h.MessageHolder();

            var panel = h.Div();
            {
                panel.AddClass("Panel");
                panel.Style.Margin("10px");
                panel.Helpers.EditorRowFor(c => c.UserCriteria.UserName).Label.Style["font-weight"] = "600";

                var grid = panel.Helpers.PagedGridFor<OETLib.Security.ROUserPaged>(c => c.UserListPageManager, c => c.UserList, false, false);
                {
                    grid.AddClass("table-responsive table table-bordered");
                    grid.Style.Margin("10px");

                    var firstGridRow = grid.FirstRow;
                    {
                        firstGridRow.AddClass("table-responsive table table-bordered");
                        firstGridRow.AddReadOnlyColumn(c => c.UserName, 200);
                        firstGridRow.AddReadOnlyColumn(c => c.FirstName, 150);
                        firstGridRow.AddReadOnlyColumn(c => c.LastName, 150);

                        var editColumn = firstGridRow.AddColumn();
                        editColumn.Style.Width = "150";
                        editColumn.Style.TextAlign = Singular.Web.TextAlign.center;
                        if (Singular.Security.Security.HasAccess("Security.Manage Users"))
                        {
                            var editButton = editColumn.Helpers.Button("Edit", Singular.Web.ButtonMainStyle.NoStyle, Singular.Web.ButtonSize.Normal, Singular.Web.FontAwesomeIcon.edit);
                            editButton.AddClass("custom_BbtnMd");
                            editButton.AddBinding(Singular.Web.KnockoutBindingString.click, "EditUser($data)");


                            var DeleteColumn = firstGridRow.AddColumn();
                            DeleteColumn.Style.Width = "150";
                            DeleteColumn.Style.TextAlign = Singular.Web.TextAlign.center;
                            var deleteButton = DeleteColumn.Helpers.Button("", Singular.Web.ButtonMainStyle.NoStyle, Singular.Web.ButtonSize.Normal, Singular.Web.FontAwesomeIcon.trash);
                            deleteButton.AddClass("SmallDeleteButton");
                            deleteButton.AddBinding(Singular.Web.KnockoutBindingString.click, "DeleteUser($data)");
                            deleteButton.Tooltip = "Delete user";
                        }
                        var SecurityColumn = firstGridRow.AddColumn();
                        SecurityColumn.Style.Width = "150";
                        SecurityColumn.Style.TextAlign = Singular.Web.TextAlign.center;
                        if (Singular.Security.Security.HasAccess("Security.Reset Passwords"))
                        {
                            var resetButton = SecurityColumn.Helpers.Button("", Singular.Web.ButtonMainStyle.NoStyle, Singular.Web.ButtonSize.Normal, Singular.Web.FontAwesomeIcon.recycle);
                            resetButton.AddClass("custom_TEbtn");
                            resetButton.AddBinding(Singular.Web.KnockoutBindingString.click, "ResetPassword($data)");
                            resetButton.Tooltip = "Reset Password";
                        }
                    }
                }
            } // panel

            var dialog = h.Dialog(
                c => c.EditingUser != null,
                c => ((c.EditingUser != null) && (c.EditingUser.IsNew)) ? "New User" : "Edit User",
                "CancelEdit");
            {
                dialog.Style.Width = "600";

                var dialogContent = dialog.Helpers.With<OETLib.Security.User>(c => c.EditingUser);
                {
                    dialogContent.Helpers.EditorRowFor(c => c.LoginName).Editor.AddBinding(Singular.Web.KnockoutBindingString.enable, c => c.IsNew);
                    dialogContent.Helpers.EditorRowFor(c => c.FirstName);
                    dialogContent.Helpers.EditorRowFor(c => c.Surname);
                    //dialogContent.Helpers.EditorRowFor(c => c.Password); // Note: If you want to allow Passwords to be changed here, also follow instructions in the User object.
                    dialogContent.Helpers.EditorRowFor(c => c.EmailAddress);

                    var table = dialogContent.Helpers.TableFor<Singular.Security.SecurityGroupUser>(c => c.SecurityGroupUserList, true, true);
                    table.AddClass("table-responsive table table-bordered");
                    table.AddNewButtonLocation = Singular.Web.Controls.Controls.TableAddButtonLocationType.InHeader;
                    table.Style.Margin("10px");
                    table.FirstRow.AddColumn(c => c.SecurityGroupID, 350);
                }

                dialog.AddConfirmationButtons("Save", "SaveUser()", "Cancel");
            }
        } // using
    %>

    <script type="text/javascript">
        Singular.OnPageLoad(function () {
            toggleMaintenanceSubMenu();
            $("#maintenance2").addClass("activeSub");
            $("#Undo").remove();
        });
        var EditUser = function (ROUser) {

            if (ROUser) {
                //Edit
                ViewModel.CallServerMethod('GetUser', { UserID: ROUser.UserID(), ShowLoadingBar: true }, function (result) {
                    if (result.Success) {
                        ViewModel.EditingUser.Set(result.Data);
                    }
                });

            } else {
                //New
                ViewModel.EditingUser.Set();
                ViewModel.EditingUser().Password('12345678');//This will be set to random on server side.
            }

        }

        var CancelEdit = function () {
            ViewModel.EditingUser.Clear();
        }

        var SaveUser = function () {

            Singular.Validation.IfValid(ViewModel.EditingUser(), function () {
                var jsonUser = ViewModel.EditingUser.Serialise();

                ViewModel.CallServerMethod('SaveUser', { User: jsonUser, ShowLoadingBar: true }, function (result) {
                    if (result.Success) {
                        ViewModel.UserListPageManager().Refresh();
                        ViewModel.EditingUser.Clear();
                        Singular.AddMessage(3, 'Saved', 'User has been saved successfully.').Fade(2000);
                    } else {
                        alert(result.ErrorText);
                    }
                });
            });
        }

        var DeleteUser = function (User) {

            Singular.ShowMessageQuestion('Delete', 'Are you sure you want to permanently delete this item?', function () {

                ViewModel.CallServerMethod('DeleteUser', { UserID: User.UserID(), ShowLoadingBar: true }, function (result) {
                    if (result.Success) {
                        ViewModel.UserList.remove(User);
                        Singular.AddMessage(3, 'Delete', 'User has been deleted successfully.').Fade(2000);
                    } else {
                        alert(result.ErrorText);
                    }
                });

            });
        }

        var ResetPassword = function (User) {
            Singular.ShowMessageQuestion('Reset Password', 'Are you sure you want to reset the password for ' + User.UserName() + '?', function () {

                ViewModel.CallServerMethod('ResetPassword', { UserName: User.UserName(), ShowLoadingBar: true }, function (result) {
                    if (result.Success) {
                        Singular.AddMessage(3, 'Reset Password', 'Users password has been reset successfully.').Fade(2000);
                    } else {
                        alert(result.ErrorText);
                    }
                });

            });
        }




    </script>

</asp:Content>
