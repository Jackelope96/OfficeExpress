<%@ Page Language="C#"
    AutoEventWireup="false"
    CodeBehind="Products.aspx.cs"
    MasterPageFile="~/Site.Master"
    Inherits="OETWeb.Maintenance.Products" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
     <style type="text/css">
       .background-colour-highlightGreen {
           
           background-color: #ADEE92;

       }

       .background-colour-highlightRed{
           background-color :#EEA792;
       }


       .btn-add{
           background-color: #4286f4;

       }

        .btn-min {
            background-color: #ff6666;
        }
        .align{
            text-align : left;
        }
        .left{

        }
       
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<%

    using (var h = Helpers)
    {
        var toolbar = h.Toolbar();
        {
            toolbar.Helpers.HTML().Heading2("Products");
        }

        h.MessageHolder();
        var btnNewProduct =  h.Button( Singular.Web.DefinedButtonType.Save , "New Product");
        btnNewProduct.AddBinding(Singular.Web.KnockoutBindingString.click, "EditProduct()");
        var excelBtn = h.Button(Singular.Web.DefinedButtonType.Export, "Export");
       excelBtn.AddBinding(Singular.Web.KnockoutBindingString.click, "Export()");

        var panel = h.Div();
        {
            panel.AddClass("Panel");
            panel.Style.Margin("10px");

            //panel.Helpers.Button(Singular.Web.DefinedButtonType.Save , "Save");

            var grid = panel.Helpers.TableFor<OETLib.BusinessObjects.Model.Product>(c => c.ProductList,  false, false);
            {
                grid.AddClass("table-responsive table table-bordered");
                grid.Style.Margin("10px");

                var firstGridRow = grid.FirstRow;
                {
                    firstGridRow.AddClass("table-responsive table table-bordered");

                    firstGridRow.AddReadOnlyColumn(c => c.ProductName, 150);
                    firstGridRow.AddReadOnlyColumn(c => c.ProductPrice , 150);
                    firstGridRow.AddReadOnlyColumn(c => c.CategoryID , 150);

                    var editColumn = firstGridRow.AddColumn();
                    editColumn.Style.Width = "150";
                    editColumn.Style.TextAlign = Singular.Web.TextAlign.center;

                    var editButton = editColumn.Helpers.Button("Edit", Singular.Web.ButtonMainStyle.NoStyle, Singular.Web.ButtonSize.Normal, Singular.Web.FontAwesomeIcon.edit);
                    editButton.AddClass("custom_BbtnMd");
                    editButton.AddBinding(Singular.Web.KnockoutBindingString.click, "EditProduct($data)");

                    var DeleteColumn = firstGridRow.AddColumn();
                    DeleteColumn.Style.Width = "150";
                    DeleteColumn.Style.TextAlign = Singular.Web.TextAlign.center;
                    var deleteButton = DeleteColumn.Helpers.Button("Remove", Singular.Web.ButtonMainStyle.NoStyle, Singular.Web.ButtonSize.Normal, Singular.Web.FontAwesomeIcon.trash);
                   // deleteButton.AddClass("SmallDeleteButton");
                    deleteButton.AddClass("btn-min");
                    deleteButton.AddBinding(Singular.Web.KnockoutBindingString.click, "DeleteProduct($data)");
                    deleteButton.Tooltip = "Delete product";


                }
            }
        } // panel

        var toolbarInventory = h.Toolbar();
        {
            toolbarInventory.Helpers.HTML().Heading2("Inventory");
        }
        var panelInventory = h.Div();
        {
            panelInventory.AddClass("Panel");
            panelInventory.Style.Margin("10px");
            //panelInventory.Style.Width = "50";

            //panel.Helpers.Button(Singular.Web.DefinedButtonType.Save , "Save");

            var grid = panelInventory.Helpers.TableFor<OETLib.BusinessObjects.Model.EditInventory>(c => c.EditInventoryList,  false, false);
            {
                grid.AddClass("table-responsive table table-bordered");
                grid.Style.Margin("10px");

                var firstGridRow = grid.FirstRow;
                {
                    firstGridRow.AddClass("table-responsive table table-bordered");

                    firstGridRow.AddReadOnlyColumn(c => c.ProductName,100);
                    var currentInv =  firstGridRow.AddReadOnlyColumn(c => c.CurrentInventoryQuantity,100 );
                    var columAction = firstGridRow.AddColumn();
                    columAction.Style.Width="50";
                    columAction.AddClass("align");

                    var btnAdd = columAction.Helpers.Button("", Singular.Web.ButtonMainStyle.Default, Singular.Web.ButtonSize.Tiny, Singular.Web.FontAwesomeIcon.plus);
                    btnAdd.AddClass("btn-add");

                    btnAdd.AddBinding(Singular.Web.KnockoutBindingString.click, "AddInventory($data)");
                    var btnMin = columAction.Helpers.Button("", Singular.Web.ButtonMainStyle.Default, Singular.Web.ButtonSize.Tiny, Singular.Web.FontAwesomeIcon.minus);
                    btnMin.AddBinding(Singular.Web.KnockoutBindingString.click, "MinInventory($data)");
                    btnMin.AddClass("btn-min");

                    currentInv.CellBindings.Add(Singular.Web.KnockoutBindingString.css, "checInventory($data.CurrentInventoryQuantity()) ? 'background-colour-highlightGreen' : 'background-colour-highlightRed'");


                }
            }
        } // panelInventory

        var dialog = h.Dialog(
            c => c.EditingProduct != null,
            c => ((c.EditingProduct != null) && (c.EditingProduct.IsNew)) ? "New Product" : "Edit Product",
            "CancelEdit");
        {
            dialog.Style.Width = "600";

            var dialogContent = dialog.Helpers.With<OETLib.BusinessObjects.Model.Product>(c => c.EditingProduct);
            {

               dialogContent.Helpers.EditorRowFor(c => c.ProductName);//.Editor.AddBinding(Singular.Web.KnockoutBindingString.enable, c => c.IsNew);
               var r =  dialogContent.Helpers.EditorRowFor(c => c.ProductPrice);
                dialogContent.Helpers.EditorRowFor(c => c.CategoryID);
                
                dialogContent.Helpers.EditorRowFor(c => c.ItemCost);
                r.AddClass("align");
                


                //dialogContent.Helpers.EditorRowFor(c => c.InventoryQuantity);
            }

            dialog.AddConfirmationButtons("Save", "SaveProduct()", "Cancel");
        }


        //////Edit Inventory Item
        //var dialog2 = h.Dialog(
        //    c => c.EditInventoryProduct != null,
        //    c => ((c.EditInventoryProduct != null)) ? "New Product" : "Edit Product",
        //    "CancelEdit");
        //{
        //    dialog2.Style.Width = "600";

        //    var dialogContent = dialog2.Helpers.With<OETLib.BusinessObjects.Model.Product>(c => c.EditInventoryProduct);
        //    {

        //        dialogContent.Helpers.ReadOnlyFor(c => c.ProductName);//.Editor.AddBinding(Singular.Web.KnockoutBindingString.enable, c => c.IsNew);
        //        dialogContent.Helpers.EditorRowFor(c => c.InventoryQuantity);
        //        dialogContent.Helpers.EditorRowFor(c => c.CurrentInventoryQuantity);
        //        dialogContent.Helpers.EditorRowFor(c => c.InventoryCostPrice);



        //        //dialogContent.Helpers.EditorRowFor(c => c.InventoryQuantity);
        //    }
        //    dialog2.AddConfirmationButtons("Save", "SaveItem()", "Cancel");
        //}

        var dialogAdd = h.Dialog(
   c => c.EditInventoryItem != null,
   c => ((c.EditInventoryItem!= null)) ? "Inventory Quantity" : "Inventory Quantity",
   "CancelEdit");
        {
            dialogAdd.Style.Width = "600";

            var dialogContent = dialogAdd.Helpers.With<OETLib.BusinessObjects.Model.EditInventory>(c => c.EditInventoryItem);
            {
                dialogContent.Helpers.EditorRowFor(c => c.InventoryAmount);
            }
            dialogAdd.AddConfirmationButtons("Save", "SaveInventoryItem ()", "Cancel");
        }



    } %>

    <script type="text/javascript">

        var EditProduct = function (Product) {

            if (Product) {
                //Edit
                ViewModel.IsNewItem = false;
                var jsonproduct = Product.Serialise();
                 ViewModel.CallServerMethod('GetProduct', { ProductID: Product.ProductID(), ShowLoadingBar: true }, function (result) {
               // ViewModel.CallServerMethod('GetProduct', { Product: jsonproduct, ShowLoadingBar: true }, function (result) {
                    if (result.Success)
                    {
                       
                        ViewModel.EditingProduct.Set(result.Data);
                       // ViewModel.EditingProduct().Refresh();
                    }
                });

            } else {
                //New
                //ViewModel.NeedInventory = true;
                ViewModel.IsNewItem = true;
                ViewModel.EditingProduct.Set();
               
            }
        }       
        
        var SaveProduct = function ()
        {

          Singular.Validation.IfValid(ViewModel.EditingProduct(), function () {
           var jsonproduct = ViewModel.EditingProduct.Serialise();
             
           if (ViewModel.IsNewItem == true)
           {
               ViewModel.CallServerMethod('SaveProduct', { Product: jsonproduct, ShowLoadingBar: true }, function (result) {
                   if (result.Success)
                   {
                       var newID = result.Data;
                       ViewModel.EditingProduct().ProductID(newID);
                       ViewModel.ProductList.Add(ViewModel.EditingProduct());
                       ViewModel.CallServerMethod('SaveInventoryProduct', { Product: jsonproduct, productid: newID, ShowLoadingBar: true }, function (result2) {
                           if (result2.Success) {
                               //I think this needs to be added to a table that is in the database actually. ex InventoryList
                               ViewModel.EditInventoryList.Set(result2.Data);
                               ViewModel.EditingProduct.Clear();
                               Singular.AddMessage(3, 'Saved', 'Product has been saved successfully.').Fade(2000);

                           }

                       });
                   }
               });                   
           }
           else if (ViewModel.IsNewItem == false)
           {
               ViewModel.CallServerMethod('UpdateProduct', { Product: jsonproduct, ShowLoadingBar: true }, function (result4) {
                   if (result4.Success)
                   {
                      // var newID = result4.Data;
                       //ViewModel.EditingProduct().ProductID(newID);
                       //ViewModel.ProductList.Add(ViewModel.EditingProduct());
                       ViewModel.ProductList.Set(result4.Data);
                       ViewModel.EditingProduct.Clear();
                       Singular.AddMessage(3, 'Edited', 'Product has been saved successfully.').Fade(2000);
                       ViewModel.CallServerMethod('UpdateInventoryItem', { Product: jsonproduct, ShowLoadingBar: true }, function (result3) {
                           if (result3.Success) {
                               //I think this needs to be added to a table that is in the database actually. ex InventoryList
                               ViewModel.EditInventoryList.Set(result3.Data);

                           }

                       });

                   }
               });

              
          }
        
            });         
        }

        //var SaveEditProduct = function ()
        //{
        //    Singular.Validation.IfValid(ViewModel.EditingProduct(), function () {
        //        var jsonproduct = ViewModel.EditingProduct.Serialise();


        //        ViewModel.CallServerMethod('SaveProduct', { Product: jsonproduct, ShowLoadingBar: true }, function (result) {
        //            if (result.Success) {
                        
        //                var newID = result.Data;
        //                ViewModel.EditingProduct().ProductID(newID);
        //                ViewModel.ProductList.Add(ViewModel.EditingProduct());
        //                ViewModel.EditingProduct.Clear();
        //                Singular.AddMessage(3, 'Edited successfully', 'Product has been saved successfully.').Fade(2000);
        //            }
        //            });

        //}

        var CancelEdit = function () {
            ViewModel.EditingProduct.Clear();
        }

        var DeleteProduct = function (Product) {

            Singular.ShowMessageQuestion('Delete', 'Are you sure you want to permanently delete this item?', function () {

                ViewModel.CallServerMethod('DeleteProduct', { productId: Product.ProductID(), ShowLoadingBar: true }, function (result) {
                    if (result.Success) {
                        ViewModel.ProductList.remove(Product);
                        ViewModel.EditInventoryList.Set(result.Data);
                        Singular.AddMessage(3, 'Delete', 'Product has been deleted successfully.').Fade(2000);
                    } else {
                        alert(result.ErrorText);
                    }
                });

            });
        }

        var Export = function ()
        {
            ViewModel.CallServerMethod('ExportData', {  ShowLoadingBar: true }, function (result) {
                if (result.Success) {
                    Singular.AddMessage(3, 'Export', 'Productlist has been exported successfully.').Fade(2000);
                } else {
                    alert(result.ErrorText);
                }
            });
        }

     

        var checInventory = function(currentInv)
        {
            if (currentInv < 20)
            {
                return false;
            }
            else
            {
                return true;
            }
        }
        //Add inventory
        var AddInventory = function (data)
        {
           
            ViewModel.EditInventoryItem.Set(data);
            
        }

        var MinInventory = function (data) {
            ViewModel.EditInventoryItem.Set(data);
            var b = ViewModel.EditInventoryItem().AddStatus(false);
            
        }

        var SaveInventoryItem = function ()
        {
            
            Singular.Validation.IfValid(ViewModel.EditInventoryItem(), function () {
                var jsonitem = ViewModel.EditInventoryItem.Serialise();

                ViewModel.CallServerMethod('SaveInventoryItem', { item: jsonitem, ShowLoadingBar: true }, function (result) {
                    if (result.Success) {
                        // ViewModel.ProductList().Refresh();
                        Singular.AddMessage(3, 'Saved', 'Product has been saved successfully.').Fade(2000);
                        ViewModel.EditInventoryItem.Clear();
                        ViewModel.EditInventoryList.Set(result.Data);
                       
                    } else {
                        alert(result.ErrorText);
                    }
                });
            });         
        }

        var TestIsNew = function ()
        {
            if (ViewModel.EditingProduct.IsNew) {
                alert();
            }
        }

       


     </script>







</asp:Content>



