using System;
using Microsoft.Office.Interop.Excel;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Singular.Security;
using Singular.Web;
using Singular.Web.Data;
using OETLib.Security;
using System.IO;
using Infragistics.Documents.Excel;

using Singular.Data;
using System.Data;

namespace OETWeb.Maintenance
{
    public partial class Products : OETPageBase<ProductsVM>
    {

    }

    public class ProductsVM : OETStatelessViewModel<ProductsVM>
    {
        //private int qty = 1;
        public bool needInventory = false;
        //public PagedDataManager<ProductsVM> ProductsListPageManager { get; set; }

        public  OETLib.BusinessObjects.Model.ProductList ProductList { get; set; }
        public String searchproduct { get; set; }
        //Just declares list and  makes available to the view
        public  OETLib.BusinessObjects.Model.Product EditingProduct { get; set; }
        public OETLib.BusinessObjects.Model.CategoryList CategoryList { get; set; }

        public OETLib.BusinessObjects.Model.InventoryList InventoryList { get; set; }
        public OETLib.BusinessObjects.Model.Inventory InventoryItem { get; set; }
        public OETLib.BusinessObjects.Model.EditInventoryList EditInventoryList { get; set; }

        public OETLib.BusinessObjects.Model.EditInventory EditInventoryItem { get; set; }
        public bool EditInventoryItemBool { get; set; }
        public OETLib.BusinessObjects.Model.Product EditInventoryProduct { get; set; }
        public bool _isNewItem = false;

        public bool IsNewItem
        {
            get
            {
                return _isNewItem;
            }
            set
            {
                _isNewItem = value;
            }
        }


        public bool NeedInventory
        {
            get
            {
                return needInventory;
            }
            set
            {
                needInventory = value;
            }
        }

        protected override void Setup()
        {

            //Actually get stuff from the database
            base.Setup();
            this.ProductList = OETLib.BusinessObjects.Model.ProductList.GetProductList();
            this.CategoryList = OETLib.BusinessObjects.Model.CategoryList.GetCategoryList();
            this.InventoryList = OETLib.BusinessObjects.Model.InventoryList.GetInventoryList();
            this.EditInventoryList = OETLib.BusinessObjects.Model.EditInventoryList.GetEditInventoryList();
            //EditInventoryItem.InventoryQuantity = 0;
        }





        [WebCallable]
        public static OETLib.BusinessObjects.Model.Product GetProduct(int productId)
        {
            var product = OETLib.BusinessObjects.Model.ProductList.GetProductList().FirstOrDefault(d => d.ProductID == productId);
            var inventory = OETLib.BusinessObjects.Model.EditInventoryList.GetEditInventoryList().FirstOrDefault(d => d.ProductID == productId);
            product.ItemCost = inventory.InventoryItemCost;
            //return OETLib.BusinessObjects.Model.ProductList.GetProductList().FirstOrDefault(d => d.ProductID == productId);
            return product;

        }

        //[WebCallable]
        //public static Result GetProduct(OETLib.BusinessObjects.Model.Product Product)
        //{
        //    Result webRes = new Result(false);
        //    try
        //    {
        //        var editProduct = new OETLib.BusinessObjects.Model.Product();
        //        editProduct = OETLib.BusinessObjects.Model.ProductList.GetProductList().FirstOrDefault(d => d.ProductID == Product.ProductID);
        //        var editInventory = new OETLib.BusinessObjects.Model.EditInventory();
        //        editInventory = OETLib.BusinessObjects.Model.EditInventoryList.GetEditInventoryList().LastOrDefault(d => d.ProductID == Product.ProductID);

        //        Product.ProductName = editProduct.ProductName;
        //        Product.CategoryID = editProduct.CategoryID;
        //        Product.ProductPrice = editProduct.ProductPrice;
        //        Product.CurrentInventoryQuantity = editInventory.CurrentInventoryQuantity;
        //        Product.InventoryQuantity = 0;
        //        Product.InventoryCostPrice = editInventory.InventoryItemCost;

        //        webRes.Data = Product;
        //        webRes.Success = true;
        //    }
        //    catch(Exception e)
        //    {
        //        webRes.ErrorText = e.Message;
        //    }
        //    return webRes;
        //    //return OETLib.BusinessObjects.Model.ProductList.GetProductList().FirstOrDefault(d => d.ProductID == productId);

        //}

        [WebCallable(Roles = new string[] { "Security.Manage Users" })]
        public Result GetInventoryItem(OETLib.BusinessObjects.Model.EditInventory inventoryItem)
        {
            Result webRes = new Result(false);
            try
            {
                var inventory_edit = new OETLib.BusinessObjects.Model.EditInventory();
                inventory_edit = OETLib.BusinessObjects.Model.EditInventoryList.GetEditInventoryList().LastOrDefault(d => d.ProductID == inventoryItem.ProductID);
                // webRes.Data = OETLib.BusinessObjects.Model.EditInventoryList.GetEditInventoryList().LastOrDefault(d => d.ProductID == inventoryItem.ProductID);
                inventoryItem.CurrentInventoryQuantity = inventory_edit.CurrentInventoryQuantity;
                inventoryItem.InventoryItemCost = inventory_edit.InventoryItemCost;
               // InventoryList.Add(inventoryItem);

                webRes.Data = inventoryItem;
                webRes.Success = true;
            }
            catch(Exception e)
            {
                webRes.ErrorText = e.Message;
            }
            return webRes;
            
             
        }



        [WebCallable(Roles = new string[] { "Security.Manage Users" })]
        public  static Result SaveProduct(OETLib.BusinessObjects.Model.Product product)
        {
            Result webRes = new Result(false);
            try
            {
                //Save product related information
                //var productToSave = new OETLib.BusinessObjects.Model.Product();       
                //productToSave.CategoryID = product.CategoryID;
                //productToSave.ProductName = product.ProductName;
                //productToSave.ProductPrice = product.ProductPrice;
                //productToSave.DeleteStatus = false;
                product.DeleteStatus = false;
                var SavedProductSaveHelper = product.TrySave(typeof(OETLib.BusinessObjects.Model.ProductList));
                // OETLib.BusinessObjects.Model.ProductList productList = OETLib.BusinessObjects.Model.ProductList.GetProductList();
                //var ProductToSave = new OETLib.BusinessObjects.Model.Product();
                //ProductToSave = product;
                //productList.Add(product);
                //productList.Refresh();
                // productList.Save();

                //product.TrySave(typeof(OETLib.BusinessObjects.Model.ProductList));

                //Inventory stuff

                //Get newly created product ProductID
                var newProduct = new OETLib.BusinessObjects.Model.Product();
                newProduct = GetProductid(product.ProductName);

                var newId = newProduct.ProductID;
                OETLib.BusinessObjects.Model.ProductList productlist = OETLib.BusinessObjects.Model.ProductList.GetProductList();
                webRes.Data = newId;
                //webRes.Data = productlist;
                webRes.Success = true;
                //SaveInventoryProduct(product, newId);


                //// Create Inventory information
                //var inventoryToSave = new OETLib.BusinessObjects.Model.Inventory();
                // inventoryToSave.ProductID = newProduct.ProductID;
                // inventoryToSave.InventoryQuantity = 0;
                // inventoryToSave.InventoryItemCost = newProduct.InventoryCostPrice;
                // inventoryToSave.CurrentInventoryQuantity = product.InventoryQuantity;//Because new inventory is added for the first time, the current level is equal to the quantity level
                // inventoryToSave.InventoryType = 1;// 1 Means that the inventory was added


                //var SavedInventory = inventoryToSave.TrySave(typeof(OETLib.BusinessObjects.Model.InventoryList));

            }
            catch(Exception e)
            {
                webRes.ErrorText = e.Message;
            }




            return webRes;
        }

        [WebCallable]
        public Result UpdateInventoryItem(OETLib.BusinessObjects.Model.Product Product)
        {
            Result webRes = new Result(false);
            try
            {
                OETLib.BusinessObjects.Model.EditInventoryList editInventoryList = OETLib.BusinessObjects.Model.EditInventoryList.GetEditInventoryList();
                webRes.Success = true;
                webRes.Data = editInventoryList;
            }
            catch(Exception e)
            {
                webRes.ErrorText = e.Message;
            }
           
            return webRes;
            
        }

        [WebCallable]
        public Result UpdateProduct (OETLib.BusinessObjects.Model.Product Product)
        {
            Result webres = new Result(false);
            try
            {
                var SavedProductSaveHelper = Product.TrySave(typeof(OETLib.BusinessObjects.Model.ProductList));
                OETLib.BusinessObjects.Model.ProductList productlist = OETLib.BusinessObjects.Model.ProductList.GetProductList();
                webres.Success = true;
                webres.Data = productlist;
            }
            catch(Exception e)
            {
                webres.ErrorText = e.Message;
            }

            return webres;
        }

        [WebCallable]
        //public static Result SaveInventoryProduct(OETLib.BusinessObjects.Model.Product product, int productid)
        public static Result SaveInventoryProduct(OETLib.BusinessObjects.Model.Product Product,int  productid)
        {
            Result webRes = new Result(false);
            
                try
                {

                    //new inventory entry
                    var inventoryToSave =  new OETLib.BusinessObjects.Model.Inventory();
                     inventoryToSave.ProductID = productid;
                    inventoryToSave.InventoryQuantity = Product.InventoryQuantity;
                    inventoryToSave.CurrentInventoryQuantity = Product.CurrentInventoryQuantity + Product.InventoryQuantity;
                    inventoryToSave.InventoryItemCost = Product.ItemCost;
                    //if(Product.InventoryQuantity >0)
                    //{
                        inventoryToSave.InventoryTypeID = 1;
                    //}
                    //else
                    //{
                    //    inventoryToSave.InventoryType = 3;
                    //}

                    var SavedInventory = inventoryToSave.TrySave(typeof(OETLib.BusinessObjects.Model.InventoryList));
                //Get the newly created inventory ID
                var newInventoryItem = new OETLib.BusinessObjects.Model.Inventory();
                newInventoryItem = OETLib.BusinessObjects.Model.InventoryList.GetInventoryList().LastOrDefault(d => d.ProductID == productid);
                //webRes.Data = newInventoryItem;//.InventoryID ;
                OETLib.BusinessObjects.Model.InventoryList inventoryList = OETLib.BusinessObjects.Model.InventoryList.GetInventoryList();
                inventoryList.Add(newInventoryItem);
                OETLib.BusinessObjects.Model.EditInventoryList editInventoryList = OETLib.BusinessObjects.Model.EditInventoryList.GetEditInventoryList();
                webRes.Data = editInventoryList;
                webRes.Success = true;
                //webRes.Data = EditInventoryList;
                   
                }
                catch (Exception e)
                {
                    webRes.ErrorText = e.Message;
                }
            return webRes;
        }

        [WebCallable]
        public static OETLib.BusinessObjects.Model.Product GetProductid(string productname)
        {

            return OETLib.BusinessObjects.Model.ProductList.GetProductList().LastOrDefault(d => d.ProductName == productname);


        }
        


        [WebCallable]
        public static Result ExportData()
        {
            var webRes = new Result(false);

            try
            {
                ////OETLib.BusinessObjects.Model.ProductList productList = OETLib.BusinessObjects.Model.ProductList.GetProductList();
                //OETLib.BusinessObjects.Model.myCartList myCartList = OETLib.BusinessObjects.Model.myCartList.GetmyCartList();
                //string path = @"C:\Clients\officeexpress.tuckshop\myCartListAAAA.xlsx";
                //MemoryStream ms = new MemoryStream();
                ////FileStream fs = new FileStream(path,FileMode.OpenOrCreate);
                //FileInfo fi = new FileInfo(path);
                //Singular.Data.ExcelExporter ee = new Singular.Data.ExcelExporter(Infragistics.Documents.Excel.WorkbookFormat.Excel2007);
                //var balancesSheet = ee.WorkBook.Worksheets.Add("TakeOnBalanceComparison");
                ////balancesSheet.Rows(1).Cells(2).ApplyFormula("=A1+B1");
                //var balance = ee.WorkBook.Worksheets.Add("11");
                //ee.PopulateData(myCartList, balancesSheet);

                //// Save workbook to file
                //ee.ShowTotalsRow = false;
                //TableRow r = new TableRow();
                ////ee.PopulateData(productList);

                //ee.WorkBook.Save(path);
                //webRes.Success = true;

                Microsoft.Office.Interop.Excel.Application xobj = new Microsoft.Office.Interop.Excel.Application();
                xobj.DisplayAlerts = false;
                Microsoft.Office.Interop.Excel.Workbook wb = xobj.Workbooks.Open(@"C:\Users\JVanzyl\Documents\BES\Invoice_template.xlsx"); 
                Microsoft.Office.Interop.Excel.Worksheet sheet = (Microsoft.Office.Interop.Excel.Worksheet)xobj.ActiveSheet;
               
                sheet.Cells[3, 3] = "AAA";
                wb.SaveAs(@"C:\test5.xlsx");  // or book.Save();
                wb.Close();




            }
            catch(Exception e)
            {
                webRes.ErrorText = e.Message;
            }

            return webRes;
        }

        [WebCallable(Roles = new string[] { "Security.Manage Users" })]
        public static Result DeleteProduct(int productId)
        {
            Result webres = new Result(false);
            try
            {
                OETLib.BusinessObjects.Model.ProductList productList = OETLib.BusinessObjects.Model.ProductList.GetProductList();
                var product = productList.FirstOrDefault(d => d.ProductID == productId);
                product.DeleteStatus = true;
                productList.Add(product);
                productList.Save();
                OETLib.BusinessObjects.Model.EditInventoryList editInventoryList = OETLib.BusinessObjects.Model.EditInventoryList.GetEditInventoryList();
                webres.Data = editInventoryList;
                webres.Success = true;
            
            }
            catch (Exception ex)
            {
                //log error
                webres.ErrorText = ex.Message;
            }

            return webres;
        }

        [WebCallable]
        public  Result SaveInventoryItem(OETLib.BusinessObjects.Model.EditInventory item)
        {
            Result webRes = new Result(false);
            try
            {
                var inventoryToSave = new OETLib.BusinessObjects.Model.Inventory();
                inventoryToSave.ProductID = item.ProductID;
                if(item.AddStatus == true)
                {
                    inventoryToSave.InventoryQuantity = item.InventoryAmount;
                    inventoryToSave.CurrentInventoryQuantity = item.CurrentInventoryQuantity + item.InventoryAmount;
                    inventoryToSave.InventoryTypeID = 1;
                }
                else
                {
                    inventoryToSave.InventoryQuantity = -item.InventoryAmount;
                    inventoryToSave.CurrentInventoryQuantity = item.CurrentInventoryQuantity - item.InventoryAmount;
                    inventoryToSave.InventoryTypeID = 3;
                }
                //inventoryToSave.InventoryQuantity = item.InventoryAmount;
                //inventoryToSave.CurrentInventoryQuantity = item.CurrentInventoryQuantity + item.InventoryAmount;
                inventoryToSave.InventoryItemCost = item.InventoryItemCost;
               
                var SavedInventory = inventoryToSave.TrySave(typeof(OETLib.BusinessObjects.Model.InventoryList));
                var newInventoryRecord = new OETLib.BusinessObjects.Model.Inventory();

                OETLib.BusinessObjects.Model.InventoryList InventoryList = OETLib.BusinessObjects.Model.InventoryList.GetInventoryList();
                InventoryList.Add(inventoryToSave);
                OETLib.BusinessObjects.Model.EditInventoryList editInventoryList = OETLib.BusinessObjects.Model.EditInventoryList.GetEditInventoryList();
                webRes.Success = true;
                webRes.Data = editInventoryList ;
            }
            catch(Exception ex)
            {
                return new Result { Success = false, ErrorText = ex.Message };
            }
            return webRes;
        }
    }


}