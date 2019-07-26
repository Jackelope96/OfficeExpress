using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using OfficeOpenXml;
using Singular.Web;

namespace OETWeb.Maintenance
{
  public partial class Reports : OETPageBase<ReportsVM>
  {

  }

  public class ReportsVM : OETStatelessViewModel<ReportsVM>
  {
    public OETLib.BusinessObjects.Model.ROUserList userList { get; set; }

    public class invoiceDetail
    {
      public int ItemNumber { get; set; }
      public string ItemName { get; set; }

      public int ItemQuantity { get; set; }
      public decimal ItemPrice { get; set; }
      public decimal ItemUnitPrice { get; set; }
    }


    protected override void Setup()
    {
      base.Setup();
      userList = OETLib.BusinessObjects.Model.ROUserList.GetROUserList();
    }

    [WebCallable]
    public Result ExportData()
    {
      Result webRes = new Result(false);
      try
      {
        OETLib.BusinessObjects.Model.myCartList userCartList = OETLib.BusinessObjects.Model.myCartList.GetmyCartList();
        List<OETLib.BusinessObjects.Model.ROUser> clientList; //List of current userID's
        List<OETLib.BusinessObjects.Model.myCart> userCart = new List<OETLib.BusinessObjects.Model.myCart>();

        var activeCarts = userCartList.Where(x => x.UserID != null).GroupBy(x => x.UserID).Select(p => p.FirstOrDefault()).ToList();
        var activeClients = activeCarts.Select(x => x.UserID).ToList();
        clientList = retrieveUserList(activeClients);

        var file = new FileInfo(@"C:\Users\JVanzyl\Documents\BES\Invoice_template.xlsx");
        ExcelPackage package = new ExcelPackage(file);

        foreach (var client in clientList)
        {
          userCartList = OETLib.BusinessObjects.Model.myCartList.GetmyCartList(client.UserID);
          var ws = package.Workbook.Worksheets.Copy("Template", client.FirstName.Substring(0, 1) + " " + client.LastName + " " + client.UserID);
          ExportToExcel(userCartList, ws, client);
        }
        package.SaveAs(new FileInfo(@"C:\Users\JVanzyl\Documents\Result_" + $"{DateTime.Now:dddd, d MMM, yyyy}" + ".xlsx"));
        webRes.Success = true;

      }
      catch (Exception e)
      {
        webRes.ErrorText = e.Message;
      }
      return webRes;
    }

    public List<OETLib.BusinessObjects.Model.ROUser> retrieveUserList(List<int> activeUsers)
    {
      OETLib.BusinessObjects.Model.ROUserList userList = OETLib.BusinessObjects.Model.ROUserList.GetROUserList();
      OETLib.BusinessObjects.Model.myCartList usersWithCarts = OETLib.BusinessObjects.Model.myCartList.GetmyCartList();
      List<OETLib.BusinessObjects.Model.ROUser> clientList = new List<OETLib.BusinessObjects.Model.ROUser>();
      foreach (var user in userList)
      {
        foreach (var activeUser in activeUsers)
        {
          if (user.UserID == activeUser)
          {
            clientList.Add(user);
          }
        }
      }
      return clientList;
    }

    public string GenerateInvoice(int UserId, decimal invoiceTotal, int deductId)
    {
      try
      {
        // Create the new invoice in the database
        var newInvoice = new OETLib.BusinessObjects.Model.Invoice();
        newInvoice.UserID = UserId;
        newInvoice.InvoiceDate = DateTime.Now;
        newInvoice.InvoiceTotal = invoiceTotal;
        if (deductId == 1)
          newInvoice.Notes = "Salary";
        else newInvoice.Notes = "Cash";

        var SavedInvoice = newInvoice.TrySave(typeof(OETLib.BusinessObjects.Model.InvoiceList));

        string invoiceNumber = (((OETLib.BusinessObjects.Model.Invoice)SavedInvoice.SavedObject).InvoiceID).ToString();

        return invoiceNumber;
      }
      catch
      {
        return "404";
      }



    }

    public void ExportToExcel(OETLib.BusinessObjects.Model.myCartList userCart, ExcelWorksheet ws, OETLib.BusinessObjects.Model.ROUser user)
    {
      try
      {
        int itemNumber = 0;
        decimal invoiceTotal = 0;
        List<invoiceDetail> detail = new List<invoiceDetail>();
        foreach (var item in userCart)
        {
          itemNumber++;
          invoiceTotal += item.UnitPrice;
          var entry = new invoiceDetail() { ItemNumber = itemNumber, ItemName = item.ProductName, ItemQuantity = item.ProductQuantity, ItemPrice = item.ProductPrice, ItemUnitPrice = item.UnitPrice };

          detail.Add(entry);
        }


        string invoiceNumber = GenerateInvoice(user.UserID, invoiceTotal, user.DeductID);

        // Bill to 
        ws.Cells[12, 3].Value = (user.FirstName).Substring(0, 1) + user.LastName;

        // Email
        ws.Cells[14, 3].Value = user.EmailAddress;

        // Invoice Number
        ws.Cells[12, 7].Value = invoiceNumber;

        // Invoice Date
        ws.Cells[14, 7].Value = DateTime.Now;
        ws.Cells[14, 7].Style.Numberformat.Format = "mmm-dd-yyyy";

        // Print invoice details
        ws.Cells[21, 2].LoadFromCollection(detail);

        // Total
        ws.Cells[21 + itemNumber + 1, 5].Value = "Total";
        ws.Cells[21 + itemNumber + 1, 5].Style.Font.Bold = true;
        ws.Cells[21 + itemNumber + 1, 6].Value = "R" + invoiceTotal;

        // Print deductable from salary 
        if (user.DeductID == 1)
          ws.Cells[17, 6].Value = "Deduct from salary";
        else { ws.Cells[17, 6].Value = "Cash"; };
      }
      catch (Exception e)
      {
        // Do nothing
      }

    }


  }
}