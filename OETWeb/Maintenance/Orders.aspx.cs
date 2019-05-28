using System;
using Singular.Web;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net.Mail;
using static OETWeb.Maintenance.Orders;

namespace OETWeb.Maintenance
{
    public partial class Orders : OETPageBase<OrdersVM>
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public class OrdersVM : OETStatelessViewModel<OrdersVM>
        {

            public OETLib.BusinessObjects.Model.UserOrdersList UserOrderList { get; set; }
            public OETLib.BusinessObjects.Model.Order Update_order { get; set; }
            public OETLib.BusinessObjects.Model.Inventory Inventory_Product { get; set; }
            public OETLib.BusinessObjects.Model.UserOrders UserOrders { get; set; }
            public static OETLib.BusinessObjects.Model.OrderDetailList orderDetailList { get; set; }
            protected override void Setup()
            {
                base.Setup();
                
                UserOrderList = OETLib.BusinessObjects.Model.UserOrdersList.GetUserOrdersList(1);
                

            }

            /*public void SendMail()
            {
                  string mailBodyhtml =             "<p>some text here</p>";
                    var msg = new MailMessage("jaco.vanzyl96@gmail.com", "jaco.vanzyl96@gmail.com", "Hello", mailBodyhtml);
                    msg.To.Add("jaco.vanzyl96@gmail.com");
                    msg.IsBodyHtml = true;
                    var smtpClient = new SmtpClient("smtp.gmail.com", 587); //if your from email address is "from@hotmail.com" then host should be "smtp.hotmail.com"**
                    smtpClient.UseDefaultCredentials = true;
                    smtpClient.Credentials = new System.Net.NetworkCredential("jaco.vanzyl96@gmail.com", "Batman8612");
                    smtpClient.EnableSsl = true;
                    smtpClient.Send(msg);
                    Console.WriteLine("Email Sended Successfully");
                
            }*/


            [WebCallable]
            public Result ChangeStatus (OETLib.BusinessObjects.Model.UserOrders order)
            {
                Result webRes = new Result(false);
                try
                {
                   

                    //set orderID from Order = userordid and update the staus of that specific order 

                    Update_order = OETLib.BusinessObjects.Model.OrderList.GetOrderList().LastOrDefault(d => d.OrderID == order.OrderID);

                   // Update_order.UserID = order.UserID;
                    //Change processtatus
                    Update_order.ProcessStatusID = 2;
                    //try and save the updated order
                   var updateOrderSaveHelper =  Update_order.TrySave(typeof(OETLib.BusinessObjects.Model.OrderList));
                    OETLib.BusinessObjects.Model.OrderList  orderList = OETLib.BusinessObjects.Model.OrderList.GetOrderList();
                   
                   // order.ProcessStatus = true;

                    //orderList.Add(Update_order);

                    //userOrderList.Save();

                    //Get the productId to be able to update the correct inventory
                    //Inventory_Product =OETLib.BusinessObjects.Model.InventoryList.GetInventoryList().LastOrDefault(d => d.ProductID == order.ProductID);
                    //var Inventory_record = new OETLib.BusinessObjects.Model.Inventory();
                    ////Set inventory elements
                    // Inventory_record.ProductID = order.ProductID;
                    // Inventory_record.InventoryQuantity = -order.ProductQuantity;
                    // Inventory_record.CurrentInventoryQuantity = Inventory_Product.CurrentInventoryQuantity - order.ProductQuantity;
                    // Inventory_record.InventoryItemCost = Inventory_Product.InventoryItemCost;
                    // Inventory_record.InventoryType = 2;



                    //Try and safe the new inventory record
                    //Inventory_record.TrySave(typeof(OETLib.BusinessObjects.Model.InventoryList));

                    // OETLib.BusinessObjects.Model.UserOrdersList userOrderList = OETLib.BusinessObjects.Model.UserOrdersList.GetUserOrdersList(false);
                    OETLib.BusinessObjects.Model.UserOrdersList userOrderList = OETLib.BusinessObjects.Model.UserOrdersList.GetUserOrdersList(1);
                    webRes.Success = true;
                    webRes.Data = userOrderList;
                   // UserOrderList.Save();

                }
                catch(Exception e)
                {
                    webRes.ErrorText = e.Message;// "There was an error adding your order";
                }
                return webRes;
                
           

            }

            [WebCallable]
            public Result GetListLength()
            {
                Result webRes = new Result(false);
                OETLib.BusinessObjects.Model.UserOrdersList userorderlist = OETLib.BusinessObjects.Model.UserOrdersList.GetUserOrdersList(1);
                
                try
                {
                    int count = 0;

                    foreach (OETLib.BusinessObjects.Model.UserOrders item in userorderlist)
                    {
                        count++;
                    }
                    webRes.Success = true;
                    webRes.Data = count;
                }
                catch(Exception e)
                {
                    webRes.ErrorText = e.Message;
                }
                return webRes;
            }

            [WebCallable]
            public Result ExpireOrder(OETLib.BusinessObjects.Model.UserOrdersList orderlist)
            {
                Result webRes = new Result(false);
                try
                {
                    //Order, OrderDetail,Inventory objects
                    OETLib.BusinessObjects.Model.Order expiredOrder = new OETLib.BusinessObjects.Model.Order();
                    OETLib.BusinessObjects.Model.OrderDetail expiredOrderDetail = new OETLib.BusinessObjects.Model.OrderDetail();
                    OETLib.BusinessObjects.Model.Inventory expiredInventory = new OETLib.BusinessObjects.Model.Inventory();
                    OETLib.BusinessObjects.Model.Inventory InventoryProduct = new OETLib.BusinessObjects.Model.Inventory();


                    foreach (OETLib.BusinessObjects.Model.UserOrders item in orderlist)
                    {
                        DateTime now = DateTime.Now;
                        DateTime orderDate = Convert.ToDateTime(item.OrderDate);
                        if ((now - orderDate).TotalMinutes >= (60) && !((now - orderDate).TotalMinutes<60 ))//(1/2)
                        {

                            expiredOrder = OETLib.BusinessObjects.Model.OrderList.GetOrderList().LastOrDefault(d => d.OrderID == item.OrderID);
                            expiredOrderDetail = OETLib.BusinessObjects.Model.OrderDetailList.GetOrderDetailList().LastOrDefault(d => d.OrderID == item.OrderID);
                            // Chnage the OrderStatus of the order
                            expiredOrder.ProcessStatusID = 3;
                            expiredOrder.TrySave(typeof(OETLib.BusinessObjects.Model.OrderList));
                            //Delete order from OrderDetail
                            OETLib.BusinessObjects.Model.OrderDetailList orderDetailList = OETLib.BusinessObjects.Model.OrderDetailList.GetOrderDetailList();
                            orderDetailList.Remove(expiredOrderDetail);
                            orderDetailList.Save();
                            
                            
                            //Create new Inventory record that reflects the canceled/expired order
                            InventoryProduct = OETLib.BusinessObjects.Model.InventoryList.GetInventoryList().LastOrDefault(d => d.ProductID == item.ProductID);
                            expiredInventory.ProductID = item.ProductID;
                            expiredInventory.InventoryQuantity = item.ProductQuantity;
                            expiredInventory.CurrentInventoryQuantity = InventoryProduct.CurrentInventoryQuantity + item.ProductQuantity;
                            expiredInventory.InventoryItemCost = InventoryProduct.InventoryItemCost;
                            expiredInventory.InventoryTypeID = 4;

                            expiredInventory.TrySave(typeof(OETLib.BusinessObjects.Model.InventoryList));
                            item.ProcessStatusID = 2;

                            OETLib.BusinessObjects.Model.UserOrdersList userorderlist = OETLib.BusinessObjects.Model.UserOrdersList.GetUserOrdersList(1);
                            webRes.Data = userorderlist;
                            webRes.Success = true;
                        }

                    }
                    
                }
                catch (Exception e)
                {
                    webRes.ErrorText = e.Message;// "There was an error adding your order";
                }
                return webRes;
            }



        }

 

    }
}