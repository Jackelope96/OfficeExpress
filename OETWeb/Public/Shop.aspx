<%@ Page Language="C#"
  AutoEventWireup="true"
  CodeBehind="Shop.aspx.cs"
  Inherits="OETWeb.Public.Shop"
  MasterPageFile="~/Site.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">

  <style type="text/css">
    .background-colour-highlight::before {
      content: "Collected";
    }

    .lbl {
      font-size: 20px;
      font-style: normal;
      font-family: 'Franklin Gothic Medium', 'Arial Narrow', Arial, sans-serif;
      padding-top: 10px;
      margin-right: 10px;
    }

    .btn-add {
      background-color: #4286f4;
    }

    .btn-min {
      background-color: #ff6666;
    }


    .background-color-normal {
    }

    .background-colour-highlightfalse {
      background-color: #ADEE92;
    }




    .background_blue {
      background-color: blue;
    }

    .backgroundRed {
      background-color: #ff6666;
    }

    .alignmentt {
      text-align: right;
      display: block;
      padding: 10px;
      float: right;
      position: relative;
    }

    .viewCart {
      text-align: center;
      margin-bottom: 10px;
      outline: none;
      padding: 10px;
      float: right;
      position: relative;
    }

    .lblFont {
      font-size: 20px;
      font-style: normal;
      font-family: 'Franklin Gothic Medium', 'Arial Narrow', Arial, sans-serif;
      padding-top: 10px;
      margin-right: 10px;
    }
  </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">



  <%


    using (var h = Helpers)
    {
      var toolbar = h.Toolbar();
      {
        toolbar.Helpers.HTML().Heading2("Shop");

      }
      h.MessageHolder();


      var cartAmount = ViewModel.totalMonthPrice;

      var FilterDiv1 = Helpers.DivC("row col-md-9");
      {

        var cartAmountlbl = Helpers.Bootstrap.LabelDisplay("  cart total : R" + (cartAmount));

        cartAmount = ViewModel.totalMonthPrice;
        cartAmountlbl.AddClass("alignmentt lblFont");
        cartAmountlbl.Style.FontSize = "20px";

        var btnCart = Helpers.Button("View cart", Singular.Web.ButtonMainStyle.Success, Singular.Web.ButtonSize.Tiny, Singular.Web.FontAwesomeIcon.shoppingCart);
        btnCart.AddBinding(Singular.Web.KnockoutBindingString.click, "ViewCart()");
        //btnCart.AddBinding(Singular.Web.KnockoutBindingString.click, "show()");
      }

      var panel = h.Div();
      {
        panel.AddClass("Panel");
        panel.Style.Margin("10px");
        //var grid = panel.Helpers.TableFor<OETLib.BusinessObjects.Model.Product>(c => c.ProductList, false, false);
        var grid = panel.Helpers.TableFor<OETLib.BusinessObjects.Model.Product>(c => c.ProductList, false, false);
        {
          grid.AddClass("table-responsive table table-bordered");
          grid.Style.Margin("10px");
          //grid.AddClass("btn");


          var firstGridRow = grid.FirstRow;
          {
            firstGridRow.AddClass("table-responsive table table-bordered");
            firstGridRow.Style.Padding("1000");

            var prodName = firstGridRow.AddReadOnlyColumn(c => c.ProductName);
            prodName.CellBindings.Add(Singular.Web.KnockoutBindingString.css, "checkInventory($data) ? 'background-color-normal' : 'backgroundRed '");
            firstGridRow.AddReadOnlyColumn(c => c.ProductPrice.ToString());

            firstGridRow.AddReadOnlyColumn(c => c.ProductQuantity);
            firstGridRow.AddReadOnlyColumn(c => c.LinePrice);

            var plusQuantity = firstGridRow.AddColumn();
            var btnPlus = plusQuantity.Helpers.Button("", Singular.Web.ButtonMainStyle.Default, Singular.Web.ButtonSize.Normal, Singular.Web.FontAwesomeIcon.plus);

            btnPlus.AddBinding(Singular.Web.KnockoutBindingString.disable, "CanDisableAdd($data)");
            btnPlus.AddBinding(Singular.Web.KnockoutBindingString.click, "ChangeQuantity($data,1)");
            btnPlus.AddClass("btn-add");
            // var minusQuantity = firstGridRow.AddColumn();
            var btnMin = plusQuantity.Helpers.Button("", Singular.Web.ButtonMainStyle.Default, Singular.Web.ButtonSize.Normal, Singular.Web.FontAwesomeIcon.minus);
            btnMin.AddBinding(Singular.Web.KnockoutBindingString.click, "ChangeQuantity($data,-1)");
            btnMin.AddBinding(Singular.Web.KnockoutBindingString.disable, "CanDisable($data)");
            btnMin.AddClass("btn-min");

          }
        }

      } // panel

      var panelTotal = h.Div();
      {
        panelTotal.AddClass("Panel");
        panelTotal.Style.Margin("10px");

        var btnOrder = Helpers.Button("Order", Singular.Web.ButtonMainStyle.Success, Singular.Web.ButtonSize.Tiny, Singular.Web.FontAwesomeIcon.check_circle_o);
        btnOrder.AddBinding(Singular.Web.KnockoutBindingString.click, "CreateTheOrder()");
        btnOrder.AddBinding(Singular.Web.KnockoutBindingString.disable, "CanDisableOrder()");
        btnOrder.AddClass("ViewCart");
        btnOrder.Style.Margin("10px");
        // btnOrder.Style.PaddingAll("10px");
        var totalRow = Helpers.HTML(


            "<label class =\"lbl ViewCart\" id =\"lblAmount\">0 </label>" +
             "<label class =\"lbl ViewCart\" id=\"mylbl\">Total :R </label>"
            );

        //btnOrder.AddClass("btn");


      }


      //var dialog = h.Dialog(
      //   c => c.Cart != null,
      //   c => ((c.Cart != null) && (c.Cart.IsNew)) ? "My Cart" : "My Cart",
      //   "CancelEdit");
      //{

      //    dialog.Style.Width = "600";
      //    dialog.Style.Height = "550";
      //    var table = dialog.Helpers.TableFor<OETLib.BusinessObjects.Model.myCart>(c => c.MyCartList, false, false);//.OrderByDescending(d=>d.OrderDate)
      //    {
      //        var productname = table.FirstRow.AddReadOnlyColumn(c => c.ProductName);
      //        table.FirstRow.AddReadOnlyColumn(c => c.ProductQuantity);
      //        table.FirstRow.AddReadOnlyColumn(c => c.ProductPrice);
      //        var orderDate = table.FirstRow.AddReadOnlyColumn(c => c.OrderDate);
      //        // oDate.CellBindings.Add(Singular.Web.KnockoutBindingString.css, "OrderDateIsToday($data.OrderDate()) ? 'background-colour-highlight' : 'background-colour-highlightfalse'");
      //        table.FirstRow.AddReadOnlyColumn(c => c.TotalPrice);
      //        var DeleteColumn = table.FirstRow.AddColumn();
      //        var pStatus = table.FirstRow.AddColumn();
      //        pStatus.Style.Width = "150";
      //        pStatus.CellBindings.Add(Singular.Web.KnockoutBindingString.css, "checkStatus($data.ProcessStatus()) ? 'background-colour-highlight' : 'background-colour-highlightfalse'");


      //    }

      //    dialog.AddConfirmationButtons("Save", "", "");
      //}//cart panel


      var dialog = h.Dialog(
         c => c.ShowCart == true,
         c => ((c.ShowCart == true)) ? "My Cart" : "My Cart",
         "CancelEdit");
      {

        dialog.Style.Width = "600";
        dialog.Style.Height = "550";
        var table = dialog.Helpers.TableFor<OETLib.BusinessObjects.Model.myCart>(c => c.MyCartList, false, false);//.OrderByDescending(d=>d.OrderDate)
        {
          var productname = table.FirstRow.AddReadOnlyColumn(c => c.ProductName);
          table.FirstRow.AddReadOnlyColumn(c => c.ProductQuantity);
          table.FirstRow.AddReadOnlyColumn(c => c.ProductPrice);
          var orderDate = table.FirstRow.AddReadOnlyColumn(c => c.OrderDate);
          // oDate.CellBindings.Add(Singular.Web.KnockoutBindingString.css, "OrderDateIsToday($data.OrderDate()) ? 'background-colour-highlight' : 'background-colour-highlightfalse'");
          table.FirstRow.AddReadOnlyColumn(c => c.TotalPrice);
          var DeleteColumn = table.FirstRow.AddColumn();
          var pStatus = table.FirstRow.AddColumn();
          pStatus.Style.Width = "150";
          pStatus.CellBindings.Add(Singular.Web.KnockoutBindingString.css, "checkStatus($data.ProcessStatusID()) ? 'background-colour-highlight' : 'background-colour-highlightfalse'");
          var cancelColum = table.FirstRow.AddColumn();
          var btnCancel = cancelColum.Helpers.Button("Cancel", Singular.Web.ButtonMainStyle.Default, Singular.Web.ButtonSize.Tiny, Singular.Web.FontAwesomeIcon.remove);
          btnCancel.AddBinding(Singular.Web.KnockoutBindingString.visible, "CheckOrder($data.ProcessStatusID())");
          btnCancel.AddBinding(Singular.Web.KnockoutBindingString.click, "CancelOrder($data)");
          
          h.HTML(
            "<label id =\"lbldeduct\">Deduct from salary ? </label><br>" +
            "<input type = \"checkbox\"  name = \"deduct\" value=\"0\" > No<br>" +
            "<input type = \"checkbox\"  name = \"deduct\" value=\"1\" > Yes<br>"

           );
        }
        dialog.AddConfirmationButtons("Close", "Hide()", "");
      }//cart panel
    }

  %>


  <script type="text/javascript">

    window.onload = function () {
            checkDeduct();
        };

    var createOrder = function (Product) {


      //    var jsonProduct = Product.Serialise()

      //    ViewModel.CallServerMethod('CreateOrder', { product: jsonProduct,  ShowLoadingBar: true }, function (result) {
      //        if (result.Success) {
      //            Singular.AddMessage(3, 'Order added', 'Your order was added successfully.').Fade(2000);
      //            ViewModel.MyCartList.set(result.Data)
      //            Singular.AddMessage(3, 'Order added', 'Your order was added successfully.').Fade(2000);
      //           //ViewModel.OrderList().Refresh();
      //            ViewModel.OrderProduct.Clear();
      //            Singular.AddMessage(3, 'Order added', 'Your order was added successfully.').Fade(2000);
      //        } else {
      //            alert(result.ErrorText);
      //        }
      //    });
    }

   
    var ViewCart = function () {
      ViewModel.CallServerMethod('GetCart', { ShowLoadingBar: true }, function (result) {
        if (result.Success) {
          //ViewModel.Cart.Set(result.Data);
          ViewModel.MyCartList.Set(result.Data);
          ViewModel.ShowCart(true);
        }
      });
    }

    var checkDeduct = function () {
      ViewModel.getUser();

    }
    var CancelEdit = function () {
      ViewModel.Cart.Clear();
    }


    var monthCalc = function (_month) {


      //var sdate = date.toString();
      //var dateDay = sdate.substring(0, 2);
      //var dateMonth = sdate.substring(3, 6);
      //var dateYear = sdate.substring(7, 11);

      var today = new Date();
      var month = new Array();
      month[0] = "Jan";
      month[1] = "Feb";
      month[2] = "Mar";
      month[3] = "Apr";
      month[4] = "May";
      month[5] = "Jun";
      month[6] = "Jul";
      month[7] = "Aug";
      month[8] = "Sep";
      month[9] = "Oct";
      month[10] = "Nov";
      month[11] = "Dec";

      return (month[month - 1]);





    }

    var checkStatus = function (status) {
      if (status == 1) {
        return false;
      }
      else
        return true;
    }

    var selectString = "";
    var totalAmount = 0;
    var objArray = new Array();
    // var total = 0;
    var initial = false;


    var CanDisable = function (data) {
      //if (data.SInfo.Properties[4]() == 0)
      if (data.SInfo.Properties[4]() == 0) {
        return true;
      }
    }

    var CanDisableAdd = function (data) {
      var b = false;
      //if (data.SInfo.Properties[4]() != 0)
      //{

      ViewModel.InventoryList().forEach(function (item) {

        if (parseInt(item.SInfo.Properties[9]()) === parseInt(data.SInfo.Properties[6]())) {
          if (item.SInfo.Properties[6]() == 0) {
            b = true;
          } else if (item.SInfo.Properties[6]() === data.SInfo.Properties[4]()) {
            b = true;
          }
          else {
            b = false;
          }
        }

      });
      //}



      if (b == true) {
        return true;
      }
      else {
        return false;
      }

    }

    var totTest = 0;

    var CanDisableOrder = function () {
      var totTest = 0;
      ViewModel.ProductList().forEach(function (item) {
        totTest += item.SInfo.Properties[4]();

      });

      if (totTest == 0) {
        return true;
      }
    }




    var ChangeQuantity = function (data, count) {
      var productQuantity = data.SInfo.Properties[4]();
      var productid = data.SInfo.Properties[6]();

      if (productQuantity == 0 && count == -1) return;

      var prevQuantity = parseInt(productQuantity);
      var currentQuantity = parseInt(productQuantity) + parseInt(count);


      var i = 0;
      var subtotal = 0;
      var total = 0;
      ViewModel.ProductList().forEach(function (item) {
        if (parseInt(item.SInfo.Properties[6]()) === parseInt(data.SInfo.Properties[6]())) {
          //Dynamically change a property on the VM to display it on the UI
          ViewModel.ProductList()[i].ProductQuantity(currentQuantity);
          subtotal += parseFloat(item.ProductPrice()) * currentQuantity;
          ViewModel.ProductList()[i].LinePrice(subtotal);
        };

        var lineprice = ViewModel.ProductList()[i].LinePrice();
        total += parseFloat(lineprice);

        i++;
      });

      ViewModel.totalMonthPrice += parseFloat(total);
      let lbl = document.getElementById('lblAmount');
      lbl.innerText = total;


    }

    var CreateTheOrder = function () {
      var jsonProductList = ViewModel.ProductList.Serialise();


      ViewModel.CallServerMethod('CreateTheOrder', { productlist: jsonProductList, ShowLoadingBar: true }, function (result) {
        if (result.Success) {

          Singular.AddMessage(3, 'Order added', 'Your order was added successfully.').Fade(2000);
          // ViewModel.ProductList.Set(result.Data);
          ViewModel.InventoryList.Set(result.Data);
          ViewModel.OrderProduct.Clear();
          ViewModel.CallServerMethod('UpdateProductList', { ShowLoadingBar: true }, function (result) {
            if (result.Success) {
              ViewModel.ProductList.Set(result.Data);
              let lbl = document.getElementById('lblAmount');

              lbl.innerText = 0;

            }
          });
        } else {
          alert(result.ErrorText);
        }
      });

      //var totMonth = 0;
      //ViewModel.MyCartList().forEach(function (item) {
      //    totMonth = totMonth + (item.SInfo.Properties[7]() * item.SInfo.Properties[13]());    
      //});

      //let lblTotMonth = document.getElementById('monthlbl'); 
      //lblTotMonth.innerText = totMonth;

    }

    //Test the inventory
    var checkInventory = function (data) {
      var b = false;
      var productQuantity = data.SInfo.Properties[4]();

      if (data.ProductQuantity != 0) {
        ViewModel.InventoryList().forEach(function (item) {
          if (parseInt(item.SInfo.Properties[9]()) === parseInt(data.SInfo.Properties[6]())) {
            if (item.SInfo.Properties[6]() === productQuantity) {

              b = true;
              Singular.AddMessage(2, 'Out of stock', 'there is only ' + productQuantity + ' items left of that product').Fade(2000);

            }
            else {
              return true;
            }
          }
          else {
            return true;
          }
        });

      }

      if (b == true) {

        return false;
      }
      else {
        return true;
      }
    }

    var loadtest = function () {
      alert("Loaded");
    }

    var show = function () {

    }

    var Hide = function () {
      ViewModel.ShowCart(false);
    }

    var CheckOrder = function (status) {
      if (status == 1) {
        return true;

      }
      else {
        return false;
      }
    }

    var CancelOrder = function (Order) {
      var jsonorder = Order.Serialise();
      ViewModel.CallServerMethod('CancelOrder', { order: jsonorder, ShowLoadingBar: true }, function (result) {
        if (result.Success) {

          Singular.AddMessage(3, 'Order cancelled', 'Your order was cancelled successfully.').Fade(2000);
          ViewModel.MyCartList.Set(result.Data);
          ViewModel.CallServerMethod('UpdateInventoryList', { ShowLoadingBar: true }, function (result2) {
            if (result2.Success) {
              ViewModel.InventoryList.Set(result2.Data);
            }
            else {
              alert(result2.ErrorText);
            }
          });
          ViewModel.CallServerMethod('UpdateProductList', { ShowLoadingBar: true }, function (result3) {
            if (result3.Success) {
              ViewModel.ProductList.Set(result3.Data);


            }
          });

        }
      });
    }













  </script>
</asp:Content>

