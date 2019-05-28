<%@ Page Language="C#"
    AutoEventWireup="true"
    MasterPageFile="~/Site.Master"
    CodeBehind="Orders.aspx.cs" 
    Inherits="OETWeb.Maintenance.Orders" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">

    
        
        <script src="C:\Clients\officeexpress.tuckshop\OETWeb\Scripts\jquery.js"></script>
        <script src="C:\Clients\officeexpress.tuckshop\OETWeb\Scripts\jquery-ui.min.js"></script>
        <link rel="stylesheet" href="C:\Clients\officeexpress.tuckshop\OETWeb\Styles\jquery-ui.min.css" type="text/css">
        

   
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<%

    using (var h = Helpers)
    {
        var toolbar = h.Toolbar();
        {
            toolbar.Helpers.HTML().Heading2("Orders");
        }
      

        h.MessageHolder();

     
        //add buttons here

        var panel = h.Div();
        {
            panel.AddClass("Panel");
            panel.Style.Margin("10px");
            //panel.Style.Height = "100";
            // panel.Style.Width ="100";

            var grid = panel.Helpers.TableFor<OETLib.BusinessObjects.Model.UserOrders>(c => c.UserOrderList,  false, false);
            {
                grid.AddClass("table-responsive table table-bordered");
                grid.Style.Margin("10px");




                var firstGridRow = grid.FirstRow;
                {
                    //firstGridRow.PropertyInfo

                    firstGridRow.AddClass("table-responsive table table-bordered");
                    // firstGridRow.AddReadOnlyColumn(c => c.OrderID , 50);
                    //` firstGridRow.AddReadOnlyColumn(c=> c.UserID);
                    firstGridRow.AddReadOnlyColumn(c => c.FirstName , 50);
                    firstGridRow.AddReadOnlyColumn(c => c.LastName , 50);
                    firstGridRow.AddReadOnlyColumn(c => c.ProductName , 50);
                    firstGridRow.AddReadOnlyColumn(c => c.ProductQuantity , 50);
                    firstGridRow.AddReadOnlyColumn(c => c.UnitPrice , 50);
                    firstGridRow.AddReadOnlyColumn(c => c.OrderDate , 50);
                    // firstGridRow.AddReadOnlyColumn(c => c.RequiredDate , 50);
                    //var s =  firstGridRow.AddReadOnlyColumn(c => c.ProcessStatus);

                    // s.CellBindings.Add(Singular.Web.KnockoutBindingString.css, "checkStatus($data.ProcessStatus()) ? 'background-colour-highlight' : ''");


                    var statusColum = firstGridRow.AddColumn();
                    statusColum.Style.Width = "150";
                    statusColum.Style.TextAlign = Singular.Web.TextAlign.center;

                    var statusBtn = statusColum.Helpers.Button("Collected", Singular.Web.ButtonMainStyle.Primary, Singular.Web.ButtonSize.Normal, Singular.Web.FontAwesomeIcon.arrow_circle_right);                   //Add gird columns here
                    statusBtn.AddBinding(Singular.Web.KnockoutBindingString.click, "ChangeStatus($data)");

                }
            }
        } // panel
    }

    %>
    <script type="text/javascript">

        window.onload = function () {
            autoComplete();
            var i = setInterval(function () { TestUserOrderList(i); }, 2000);
        };

        function autoComplete() {
            var v = $("#autocomplete").val();
            $("#autocomplete").autocomplete({ source: ["AI", "AB"] });
            
        };

        var ChangeStatus = function (Order)
        {
            var jsonOrder = Order.Serialise()

            ViewModel.CallServerMethod('ChangeStatus', { order: jsonOrder, ShowLoadingBar: true }, function (result) {
                if (result.Success)
                {        
                    Singular.AddMessage(3, 'Order status changed', 'Order status changed succesfull.').Fade(2000);
                    ViewModel.UserOrderList.Set(result.Data)
                }
                else {
                    alert(result.ErrorText);
                }
            });
        }

        var ExpireFunction = function () {

            var jsonUserOrderList = ViewModel.UserOrderList.Serialise();
            ViewModel.CallServerMethod('ExpireOrder', { orderlist: jsonUserOrderList, ShowLoadingBar: true }, function (result) {
                if (result.Success) {
                    ViewModel.UserOrderList.Set(result.Data);
                }
                else {
                    //alert(result.ErrorText);
                }
            });
        }
         
        var TestUserOrderList = function (i) {
            ViewModel.CallServerMethod('GetListLength', { ShowLoadingBar: true }, function (result) {
                if (result.Success) {                  
                    if (result.Data != 0) {
                        ExpireFunction();
                    }
                    else {
                        clearInterval(i);
                    }
                }
            });
          }
              
           
          
        
      


</script>


        


</asp:Content>