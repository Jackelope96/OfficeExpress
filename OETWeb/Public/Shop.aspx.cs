﻿using OETLib.Server;
using Singular.Web.Data;
using Singular.Security;
using Singular.Web;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using System.Runtime.Serialization.Formatters;
using System.Data.Linq;

namespace OETWeb.Public
{
    public partial class Shop : OETPageBase<ShopVM>
    {
        
    }

    public class ShopVM: OETStatelessViewModel<ShopVM>
    {
        public OETLib.BusinessObjects.Model.myCartList MyCartList { get; set; }
        public int totUnitPrice = 0;
        public decimal totalMonthPrice = 0;
        public OETLib.BusinessObjects.Model.ProductList ProductList { get; set; }
        public OETLib.BusinessObjects.Model.EditInventoryList InventoryList { get; set; }
        public String searchproduct { get; set; }
        public OETLib.BusinessObjects.Model.Inventory Inventory_Product { get; set; }
        public OETLib.BusinessObjects.Model.Product OrderProduct { get; set; }
        public OETLib.BusinessObjects.Model.Product prodQ { get; set; }
        public OETLib.BusinessObjects.Model.Order newOrder { get; set; }
        public OETLib.BusinessObjects.Model.OrderDetail myOrder { get; set; }

        public OETLib.BusinessObjects.Model.myCart Cart { get; set; }
        public OETLib.BusinessObjects.Model.CategoryList CategoryList { get; set; }
        public OETLib.BusinessObjects.Model.OrderDetailList OrderDetailList { get; set; }
        public OETLib.Server.General.GeneralUserList  getUser{ get; set; }
        private bool _ShowCart = false;

        public bool ShowCart
        {
            get
            {
                return _ShowCart;
            }
            set
            {
                _ShowCart = value;
            }
        }

  
        public OETLib.BusinessObjects.Model.OrderList OrderList { get; set; }
        protected override void Setup()
        {

            //Actually get stuff from the database
            
            base.Setup();
            var userid = Singular.Settings.CurrentUserID;
            MyCartList = OETLib.BusinessObjects.Model.myCartList.GetmyCartList(userid);
            ProductList = OETLib.BusinessObjects.Model.ProductList.GetProductList();
            OrderList = OETLib.BusinessObjects.Model.OrderList.GetOrderList();
            CategoryList = OETLib.BusinessObjects.Model.CategoryList.GetCategoryList();
            OrderDetailList = OETLib.BusinessObjects.Model.OrderDetailList.GetOrderDetailList();
            // MyCartList = OETLib.BusinessObjects.Model.myCartList.GetmyCartList();                    
            InventoryList = OETLib.BusinessObjects.Model.EditInventoryList.GetEditInventoryList();
            getUser = OETLib.Server.General.GeneralUserList.GetGeneralUserList(userid);

            //Add this to the order button as well
      foreach (OETLib.BusinessObjects.Model.myCart item in MyCartList)
            {
                totalMonthPrice = totalMonthPrice + (item.ProductQuantity *item.ProductPrice);
            }



        }

        [WebCallable(Roles = new string[] { "Customer.Access" })]
        public  Result CreateOrder(OETLib.BusinessObjects.Model.Product product)
        {

            Result webREs = new Result(false);
            try
            {
                //Create the order
                var order = new OETLib.BusinessObjects.Model.Order();
                OrderProduct = OETLib.BusinessObjects.Model.ProductList.GetProductList().FirstOrDefault(d => d.ProductID == product.ProductID);


                var orderdate = new DateTime();
                orderdate = DateTime.Now;
                var requireddate = new DateTime();
                requireddate = DateTime.Now;
                
                order.UserID = Singular.Settings.CurrentUserID;
                order.OrderDate = orderdate;
                order.ProcessStatusID = 1;
                order.RequiredDate = requireddate;  

                //Save the order
                var savedToOrder  = order.TrySave(typeof(OETLib.BusinessObjects.Model.OrderList));


                //Return the just saved OrderID
                var newOrder = new OETLib.BusinessObjects.Model.Order();
                newOrder = GetOrder(Singular.Settings.CurrentUserID);
               

                //Create orderDetail
                var orderDetail = new OETLib.BusinessObjects.Model.OrderDetail();
                orderDetail.OrderID = newOrder.OrderID;
                orderDetail.ProductID = OrderProduct.ProductID;
                orderDetail.ProductQuantity = product.ProductQuantity;
                orderDetail.UnitPrice = product.ProductPrice;
                //Save newly created OrderDetail

                
                
                webREs.Success = true;
                webREs.Data = orderDetail; 
            }
            catch
            {
                webREs.ErrorText="There was an error adding your order" ;
            }
            return webREs;
        }

        [WebCallable(Roles = new string[] { "Customer.Access" })]
        public static OETLib.BusinessObjects.Model.Order GetOrder(int userid)
        {

           return OETLib.BusinessObjects.Model.OrderList.GetOrderList().LastOrDefault(d => d.UserID == userid);
            

        }

        [WebCallable(Roles = new string[] { "Customer.Access" })]

        public Result CreateTheOrder(OETLib.BusinessObjects.Model.ProductList productlist)
        {
            Result webRes = new Result(false);
            try
            {
                
                foreach (OETLib.BusinessObjects.Model.Product product in productlist )
                {
                    if(product.ProductQuantity !=0)
                    {
                        var order = new OETLib.BusinessObjects.Model.Order();

                        order.UserID = Singular.Settings.CurrentUserID;
                        order.OrderDate = DateTime.Now;
                        order.ProcessStatusID = 1;
                        order.RequiredDate = order.OrderDate = DateTime.Now;

                        //Save the order
                        var savedToOrder = order.TrySave(typeof(OETLib.BusinessObjects.Model.OrderList));
                        //Return the just saved OrderID
                        var newOrder = new OETLib.BusinessObjects.Model.Order();
                        newOrder = GetOrder(Singular.Settings.CurrentUserID);
                        //Create orderDetail
                        var orderDetail = new OETLib.BusinessObjects.Model.OrderDetail();
                        orderDetail.OrderID = newOrder.OrderID;
                        orderDetail.ProductID = product.ProductID;
                        orderDetail.ProductQuantity = product.ProductQuantity;
                        orderDetail.UnitPrice = (decimal) product.LinePrice;


                        //Save newly created OrderDetail
                        var saveToOrderDetail = orderDetail.TrySave(typeof(OETLib.BusinessObjects.Model.OrderDetailList));

                        // Get the productId to be able to update the correct inventory
                        //var Inventory_product = new OETLib.BusinessObjects.Model.Inventory();
                        var Inventory_product = OETLib.BusinessObjects.Model.InventoryList.GetInventoryList().LastOrDefault(d => d.ProductID == product.ProductID);
                        var Inventory_record = new OETLib.BusinessObjects.Model.Inventory();


                        //Set inventory elements
                        Inventory_record.ProductID = product.ProductID;
                        Inventory_record.InventoryQuantity = -product.ProductQuantity;
                        Inventory_record.CurrentInventoryQuantity = Inventory_product.CurrentInventoryQuantity - product.ProductQuantity;
                        Inventory_record.InventoryItemCost = Inventory_product.InventoryItemCost;
                        Inventory_record.InventoryTypeID = 2;
                        //Try and safe the new inventory record
                        Inventory_record.TrySave(typeof(OETLib.BusinessObjects.Model.InventoryList));

                        OETLib.BusinessObjects.Model.myCartList mycartlist = OETLib.BusinessObjects.Model.myCartList.GetmyCartList(Singular.Settings.CurrentUserID);
                        
                        
                    }
                    
                }
                webRes.Success = true;
                OETLib.BusinessObjects.Model.EditInventoryList inventorylist = OETLib.BusinessObjects.Model.EditInventoryList.GetEditInventoryList();
                webRes.Data = inventorylist;
            }
            catch
            {
                webRes.ErrorText = "There was an error adding your orderr";
            }
            return webRes;
        }

        [WebCallable(Roles = new string[] { "Customer.Access" })]
        public Result UpdateProductList()
        {
            Result webRes = new Result(false);
            try
            {
                OETLib.BusinessObjects.Model.ProductList productlist = OETLib.BusinessObjects.Model.ProductList.GetProductList();
               // OETLib.BusinessObjects.Model.InventoryList inventorylist = OETLib.BusinessObjects.Model.InventoryList.GetInventoryList();
                webRes.Data = productlist;
                webRes.Success = true;
            }
            catch
            {
                webRes.ErrorText = "There was an error updating the productlist";
            }
            return webRes;
        }

        [WebCallable(Roles = new string[] { "Customer.Access" })]
        public Result UpdateInventoryList()
        {
            Result webRes = new Result(false);
            try
            {
               // OETLib.BusinessObjects.Model.ProductList productlist = OETLib.BusinessObjects.Model.ProductList.GetProductList();
                OETLib.BusinessObjects.Model.InventoryList inventorylist = OETLib.BusinessObjects.Model.InventoryList.GetInventoryList();
                webRes.Data = inventorylist;
                webRes.Success = true;
            }
            catch
            {
                webRes.ErrorText = "There was an error updating the productlist";
            }
            return webRes;
        }



        [WebCallable(Roles = new string[] { "Customer.Access" })]

        public Result GetCart()
        {
            var webRes = new Result(false);

            try
            {
                var userid = Singular.Settings.CurrentUserID;
                var currentDate = new DateTime();
                currentDate = DateTime.Now;

               
                OETLib.BusinessObjects.Model.myCartList mycartlist = OETLib.BusinessObjects.Model.myCartList.GetmyCartList(userid);
                

               // webRes.Data = OETLib.BusinessObjects.Model.myCartList.GetmyCartList().LastOrDefault(d => d.UserID == userid);
                webRes.Data = mycartlist;
                //webRes.Data = MyCartList.LastOrDefault(d => d.UserID == userid);
                //           
                webRes.Success = true;
               
            }
            catch
            {
                webRes.ErrorText = "There was a problem viewing your order";
            }
            return webRes;
        }


        [WebCallable(Roles = new string[] { "Customer.Access" })]

        public Result CancelOrder(OETLib.BusinessObjects.Model.myCart order)
        {
            Result webRes = new Result(false);
            try
            {
                //Delete Order from OrderDetail table
                OETLib.BusinessObjects.Model.OrderDetailList orderdetailList = OETLib.BusinessObjects.Model.OrderDetailList.GetOrderDetailList();
                var OrderDetailToDelete = OETLib.BusinessObjects.Model.OrderDetailList.GetOrderDetailList().LastOrDefault(d => d.OrderID == order.OrderID);
                orderdetailList.Remove(OrderDetailToDelete);
                orderdetailList.Save();

                //Delete canceled order from Order table
                OETLib.BusinessObjects.Model.OrderList orderlist = OETLib.BusinessObjects.Model.OrderList.GetOrderList();
                var OrderToDelete = OETLib.BusinessObjects.Model.OrderList.GetOrderList().LastOrDefault(d=>d.OrderID ==order.OrderID);
                orderlist.Remove(OrderToDelete);
                orderlist.Save();

                //Update the inventory stock levels. Stock needs to be added back to the inventory amounts
                
                //Get the latest inventory item to update in inventory
                var inventoryToUpdate = OETLib.BusinessObjects.Model.InventoryList.GetInventoryList().LastOrDefault(d => d.ProductID == order.ProductID);

                //new inventory record is created with the updated values
                var inventoryToCancel = new OETLib.BusinessObjects.Model.Inventory();
                inventoryToCancel.ProductID = order.ProductID;
                inventoryToCancel.InventoryQuantity = order.ProductQuantity;
                inventoryToCancel.CurrentInventoryQuantity = inventoryToUpdate.CurrentInventoryQuantity + order.ProductQuantity;
                inventoryToCancel.InventoryItemCost = inventoryToUpdate.InventoryItemCost;
                inventoryToCancel.InventoryTypeID = 4;

                inventoryToCancel.TrySave(typeof(OETLib.BusinessObjects.Model.InventoryList));

                var userid = Singular.Settings.CurrentUserID;
                OETLib.BusinessObjects.Model.myCartList mycartlist = OETLib.BusinessObjects.Model.myCartList.GetmyCartList(userid);

                webRes.Data = mycartlist;
                webRes.Success = true;
            }
            catch
            {
                webRes.ErrorText = "There was a problem cancelling order";
            }
            return webRes;
        }






    }



}
