using System;
using System.Linq;
using Singular.Web;

namespace OETWeb.Maintenance
{
  public partial class Products : OETPageBase<ProductsVM>
  {

  }

  public class ProductsVM : OETStatelessViewModel<ProductsVM>
  {
    public OETLib.BusinessObjects.Model.ProductList ProductList { get; set; }
    public OETLib.BusinessObjects.Model.Product EditingProduct { get; set; }
    public OETLib.BusinessObjects.Model.CategoryList CategoryList { get; set; }

    public OETLib.BusinessObjects.Model.InventoryList InventoryList { get; set; }
    public OETLib.BusinessObjects.Model.Inventory InventoryItem { get; set; }
    public OETLib.BusinessObjects.Model.EditInventoryList EditInventoryList { get; set; }

    public OETLib.BusinessObjects.Model.EditInventory EditInventoryItem { get; set; }
    public bool EditInventoryItemBool { get; set; }
    public OETLib.BusinessObjects.Model.Product EditInventoryProduct { get; set; }
    public bool _isNewItem = false;
    public bool needInventory = false;

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
      base.Setup();
      this.ProductList = OETLib.BusinessObjects.Model.ProductList.GetProductList();
      this.CategoryList = OETLib.BusinessObjects.Model.CategoryList.GetCategoryList();
      this.InventoryList = OETLib.BusinessObjects.Model.InventoryList.GetInventoryList();
      this.EditInventoryList = OETLib.BusinessObjects.Model.EditInventoryList.GetEditInventoryList();
    }

    [WebCallable]
    public static OETLib.BusinessObjects.Model.Product GetProduct(int productId)
    {
      var product = OETLib.BusinessObjects.Model.ProductList.GetProductList().FirstOrDefault(d => d.ProductID == productId);
      var inventory = OETLib.BusinessObjects.Model.EditInventoryList.GetEditInventoryList().FirstOrDefault(d => d.ProductID == productId);
      product.ItemCost = inventory.InventoryItemCost;
      return product;
    }

    [WebCallable(Roles = new string[] { "Security.Manage Users" })]
    public Result GetInventoryItem(OETLib.BusinessObjects.Model.EditInventory inventoryItem)
    {
      Result webRes = new Result(false);
      try
      {
        var inventory_edit = new OETLib.BusinessObjects.Model.EditInventory();
        inventory_edit = OETLib.BusinessObjects.Model.EditInventoryList.GetEditInventoryList().LastOrDefault(d => d.ProductID == inventoryItem.ProductID);
        inventoryItem.CurrentInventoryQuantity = inventory_edit.CurrentInventoryQuantity;
        inventoryItem.InventoryItemCost = inventory_edit.InventoryItemCost;
        webRes.Data = inventoryItem;
        webRes.Success = true;
      }
      catch (Exception e)
      {
        webRes.ErrorText = e.Message;
      }
      return webRes;
    }

    [WebCallable(Roles = new string[] { "Security.Manage Users" })]
    public static Result SaveProduct(OETLib.BusinessObjects.Model.Product product)
    {
      Result webRes = new Result(false);
      try
      {
        product.DeleteStatus = false;
        product.ProductPrice *=(decimal)1.15;
        var SavedProductSaveHelper = product.TrySave(typeof(OETLib.BusinessObjects.Model.ProductList));

        // Inventory stuff

        // Get newly created product ProductID
        var newProduct = new OETLib.BusinessObjects.Model.Product();
        newProduct = GetProductid(product.ProductName);

        var newId = newProduct.ProductID;
        OETLib.BusinessObjects.Model.ProductList productlist = OETLib.BusinessObjects.Model.ProductList.GetProductList();
        webRes.Data = newId;
        webRes.Success = true;
      }
      catch (Exception e)
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
      catch (Exception e)
      {
        webRes.ErrorText = e.Message;
      }
      return webRes;
    }

    [WebCallable]
    public Result UpdateProduct(OETLib.BusinessObjects.Model.Product Product)
    {
      Result webres = new Result(false);
      try
      {
        
        var SavedProductSaveHelper = Product.TrySave(typeof(OETLib.BusinessObjects.Model.ProductList));
        OETLib.BusinessObjects.Model.ProductList productlist = OETLib.BusinessObjects.Model.ProductList.GetProductList();
        webres.Success = true;
        webres.Data = productlist;
      }
      catch (Exception e)
      {
        webres.ErrorText = e.Message;
      }

      return webres;
    }

    [WebCallable]
    public static Result SaveInventoryProduct(OETLib.BusinessObjects.Model.Product Product, int productid)
    {
      Result webRes = new Result(false);

      try
      {
        //new inventory entry
        var inventoryToSave = new OETLib.BusinessObjects.Model.Inventory();
        inventoryToSave.ProductID = productid;
        inventoryToSave.InventoryQuantity = Product.InventoryQuantity;
        inventoryToSave.CurrentInventoryQuantity = Product.CurrentInventoryQuantity + Product.InventoryQuantity;
        inventoryToSave.InventoryItemCost = Product.ItemCost;
        inventoryToSave.InventoryTypeID = 1;

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
        webres.ErrorText = ex.Message;
      }
      return webres;
    }

    [WebCallable]
    public Result SaveInventoryItem(OETLib.BusinessObjects.Model.EditInventory item)
    {
      Result webRes = new Result(false);
      try
      {
        var inventoryToSave = new OETLib.BusinessObjects.Model.Inventory();
        inventoryToSave.ProductID = item.ProductID;
        if (item.AddStatus == true)
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
        inventoryToSave.InventoryItemCost = item.InventoryItemCost;
        inventoryToSave.OrderID = null;

        var SavedInventory = inventoryToSave.TrySave(typeof(OETLib.BusinessObjects.Model.InventoryList));
        var newInventoryRecord = new OETLib.BusinessObjects.Model.Inventory();

        OETLib.BusinessObjects.Model.InventoryList InventoryList = OETLib.BusinessObjects.Model.InventoryList.GetInventoryList();
        InventoryList.Add(inventoryToSave);
        OETLib.BusinessObjects.Model.EditInventoryList editInventoryList = OETLib.BusinessObjects.Model.EditInventoryList.GetEditInventoryList();
        webRes.Success = true;
        webRes.Data = editInventoryList;
      }
      catch (Exception ex)
      {
        return new Result { Success = false, ErrorText = ex.Message };
      }
      return webRes;
    }
  }


}