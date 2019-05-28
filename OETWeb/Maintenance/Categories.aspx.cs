using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Singular.Security;
using Singular.Web;
using Singular.Web.Data;

namespace OETWeb.Maintenance
{
    public partial class Categories : OETPageBase<CategoriesVM>
    {
        
    }

    public class CategoriesVM : OETStatelessViewModel<CategoriesVM>
    {
        
        public OETLib.BusinessObjects.Model.CategoryList CategoryList { get; set; }
        public OETLib.BusinessObjects.Model.Category EditItem { get; set; }

        protected override void Setup()
        {
            base.Setup();
            CategoryList = OETLib.BusinessObjects.Model.CategoryList.GetCategoryList();
        }

        //[WebCallable]
        //public static OETLib.BusinessObjects.Model.Category GetCategory()
        //{

        //    return OETLib.BusinessObjects.Model.Category.NewCategory();
        //}


        [WebCallable(Roles = new string[] { "Security.Manage Users" })]
        public static Result SaveItem(OETLib.BusinessObjects.Model.Category category)
        {
            var webRes = new Result(false);
            {
                try
                {
                    
                        var e =  category.TrySave(typeof(OETLib.BusinessObjects.Model.CategoryList));
                    
                    webRes.Success = true;
                }
                catch
                {
                    webRes.ErrorText = "There was a problem saving the object ";
                }
            }
            return webRes;
        }

        [WebCallable]
        public static Result  GetCategory(int  categoryID)
        {
            var webRes = new Result(false);
            try
            {
                var item = new OETLib.BusinessObjects.Model.Category();

                webRes.Data= OETLib.BusinessObjects.Model.CategoryList.GetCategoryList().FirstOrDefault(d => d.CategoryID == categoryID);
                webRes.Success = true;
            }
            catch
            {
                webRes.ErrorText = "There was a problem getting the object ";
            }
            //return new SaveResult(category.TrySave(typeof(OETLib.BusinessObjects.Model.CategoryList.GetCategoryList().FirstOrDefault(d => d.CategoryID == categoryID)));
            return webRes;  
        }

        [WebCallable(Roles = new string[] { "Security.Manage Users" })]
        public static Result DeleteItem(int categoryId)
        {
            try
            {
                OETLib.BusinessObjects.Model.CategoryList categoryList = OETLib.BusinessObjects.Model.CategoryList.GetCategoryList();
                var product = categoryList.FirstOrDefault(d => d.CategoryID == categoryId);
                var index = categoryList.IndexOf(product);
                categoryList.RemoveAt(index);
                categoryList.Save();
            }
            catch (Exception ex)
            {
                //log error
                return new Result { Success = false, ErrorText = ex.Message };
            }

            return new Result(true);
        }





    }
}