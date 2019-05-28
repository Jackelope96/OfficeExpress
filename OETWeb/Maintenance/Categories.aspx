<%@ Page Language="C#"
    AutoEventWireup="true"
    CodeBehind="Categories.aspx.cs"
    MasterPageFile="~/Site.Master"
    Inherits="OETWeb.Maintenance.Categories" %>


<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <%
        


        using (var h = Helpers)
        {
            var toolbar = h.Toolbar();
            {
                toolbar.Helpers.HTML().Heading2("Categories");

            }

            var btnNewCategory = h.Button(Singular.Web.DefinedButtonType.Save, "New Category");
            btnNewCategory.AddBinding(Singular.Web.KnockoutBindingString.click, "AddNewItem()");

            h.MessageHolder();

            // h.Button(Singular.Web.DefinedButtonType.Save, "Save");


            var panel = h.Div();
            {
                panel.AddClass("Panel");
                panel.Style.Margin("10px");


                var grid = panel.Helpers.TableFor<OETLib.BusinessObjects.Model.Category>(c => c.CategoryList, false, false);
                {
                    grid.AddClass("table-responsive table table-bordered");
                    grid.Style.Margin("10px");

                    var firstGridRow = grid.FirstRow;
                    {
                        firstGridRow.AddClass("table-responsive table table-bordered");
                        firstGridRow.AddReadOnlyColumn(c => c.CategoryID, 50);
                        firstGridRow.AddReadOnlyColumn(c => c.CategoryName, 150);


                        var editColumn = firstGridRow.AddColumn();
                        editColumn.Style.Width = "150";
                        editColumn.Style.TextAlign = Singular.Web.TextAlign.center;
                        if (Singular.Security.Security.HasAccess("Security.Manage Users"))
                        {
                            var editButton = editColumn.Helpers.Button("Edit", Singular.Web.ButtonMainStyle.NoStyle, Singular.Web.ButtonSize.Normal, Singular.Web.FontAwesomeIcon.edit);
                            editButton.AddClass("custom_BbtnMd");
                            editButton.AddBinding(Singular.Web.KnockoutBindingString.click, "AddNewItem($data)");
                        }

                    }
                }
            } // panel

            var dialog = h.Dialog(
                c => c.EditItem != null,
                c => ((c.EditItem != null) && (c.EditItem.IsNew)) ? "new Category" : "Edit Category",
                "CancelEdit");
            {
                dialog.Style.Width = "600";

                var dialogContent = dialog.Helpers.With<OETLib.BusinessObjects.Model.Category>(c => c.EditItem);
                {
                    dialogContent.Helpers.EditorRowFor(c => c.CategoryName);//.Editor.AddBinding(Singular.Web.KnockoutBindingString.enable, c => c.IsNew);
                }
                dialog.AddConfirmationButtons("Save", "SaveItem()", "Cancel");
            }

        }
    %>

    <script type="text/javascript">
        var AddNewItem = function (Category) {

            if (Category) {
                //Edit
                  ViewModel.CallServerMethod('GetCategory', { categoryID: Category.CategoryID(), ShowLoadingBar: true }, function (result) {
                      if (result.Success) {
                          ViewModel.EditItem.Set(result.Data);
                      }
                  }); 

                //ViewModel.EditItem(Category);

            } else {
                //New
                ViewModel.EditItem.Set();
            }
        }

        var SaveItem = function () {

            Singular.Validation.IfValid(ViewModel.EditItem(), function () {
                var jsonitem = ViewModel.EditItem.Serialise();

                ViewModel.CallServerMethod('SaveItem', { Category: jsonitem, ShowLoadingBar: true }, function (result) {
                    if (result.Success) {
                        // ViewModel.ProductList().Refresh();
                        ViewModel.EditItem.Clear();
                        Singular.AddMessage(3, 'Saved', 'Category has been saved successfully.').Fade(2000);
                    } else {
                        alert(result.ErrorText);
                    }
                });
            });
        }

        var DeleteItem = function (Category) {

            Singular.ShowMessageQuestion('Delete', 'Are you sure you want to permanently delete this item?', function () {

                ViewModel.CallServerMethod('DeleteItem', { categoryId: Category.CategoryID(), ShowLoadingBar: true }, function (result) {
                    if (result.Success) {
                        ViewModel.CategoryList.remove(Category);
                        Singular.AddMessage(3, 'Delete', 'Item has been deleted successfully.').Fade(2000);
                    } else {
                        alert(result.ErrorText);
                    }
                });

            });
        }
        var CancelEdit = function () {
            ViewModel.EditItem.Clear();
        }



    </script>



</asp:Content>
