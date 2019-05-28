﻿// Generated 07 Feb 2019 11:54 - Singular Systems Object Generator Version 2.2.699
//<auto-generated/>
using System;
using Csla;
using Csla.Serialization;
using Csla.Data;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using Singular;
using Singular.DataAnnotations;
using System.Data;
using System.Data.SqlClient;


namespace OETLib.BusinessObjects.Model
{
    [Serializable]
    public class Product
     : SingularBusinessBase<Product>
    {
        #region " Properties and Methods "

        #region " Properties "


        private int qty;
        public int ProductQuantity
        {
            get
            {
                return qty;
            }
            set
            {
                qty = value;
            }
        }
        private bool _changed = false;
        public bool Changed
        {
            get
            {
                return _changed;

            }
            set
            {
                _changed = value;
            }
        }

        
        public static PropertyInfo<int> ProductIDProperty = RegisterProperty<int>(c => c.ProductID, "ID", 0);
        /// <summary>
        /// Gets the ID value
        /// </summary>
        [Display(AutoGenerateField = false), Key]
        public int ProductID
        {
            get { return GetProperty(ProductIDProperty); }
        }


        // public static PropertyInfo<int> ProductIDProperty = RegisterProperty<int>(c => c.ProductID, "ID", 0);

        public static PropertyInfo<int?> CategoryIDProperty = RegisterProperty<int?>(c => c.CategoryID, "Category", null);
        /// <summary>
        /// Gets and sets the Category value
        /// </summary>
        [Display(Name = "Category", Description = ""),
        Required(ErrorMessage = "Category required"),

          //Add for dropdown
          Singular.DataAnnotations.DropDownWeb(typeof(CategoryList))]


        public int? CategoryID
        {
            get { return GetProperty(CategoryIDProperty); }
            set { SetProperty(CategoryIDProperty, value); }
        }

        public static PropertyInfo<string> ProductNameProperty = RegisterProperty<string>(c => c.ProductName, "Product Name", "");
        /// <summary>
        /// Gets and sets the Product Name value
        /// </summary>
        [Display(Name = "Product Name", Description = ""),
        StringLength(255, ErrorMessage = "Product Name cannot be more than 255 characters"),Required]
        public string ProductName
        {
            get { return GetProperty(ProductNameProperty); }
            set { SetProperty(ProductNameProperty, value); }
        }

        public static PropertyInfo<decimal> ProductPriceProperty = RegisterProperty<decimal>(c => c.ProductPrice, "Product Price", (decimal)0);
        /// <summary>
        /// Gets and sets the Product Price value
        /// </summary>
        [Display(Name = "Product Price", Description = ""),
        Required(ErrorMessage = "Product Price required")]
        public decimal ProductPrice
        {
            get { return GetProperty(ProductPriceProperty); }
            set { SetProperty(ProductPriceProperty, value); }
        }



        public static PropertyInfo<SmartDate> CreatedDateProperty = RegisterProperty<SmartDate>(c => c.CreatedDate, "Created Date");
        /// <summary>
        /// Gets the Created Date value
        /// </summary>
        [Display(AutoGenerateField = false)]
        public SmartDate CreatedDate
        {
            get { return GetProperty(CreatedDateProperty); }
        }

        public static PropertyInfo<Boolean> DeleteStatusProperty = RegisterProperty<Boolean>(c => c.DeleteStatus, "DeleteStatus");
        /// <summary>
        /// Gets the Created Date value
        /// </summary>
        [Display(Name = "Product Price", Description = ""),
         Required(ErrorMessage = "Product Price required")]


        public Boolean DeleteStatus
        {
            get { return GetProperty(DeleteStatusProperty); }
            set { SetProperty(DeleteStatusProperty, value); }
        }

        
       
        public int InventoryQuantity {get;set;}
       
        public decimal InventoryCostPrice { get; set; }

        public int CurrentInventoryQuantity { get; set; }

        public double LinePrice { get; set; }

        public decimal ItemCost { get; set; }
       

        //public static PropertyInfo<Boolean> NeedStockStatusProperty = RegisterProperty<Boolean>(c => c.NeedStockStatus, "Product Name");
        ///// <summary>
        ///// Gets and sets the Product Name value
        ///// </summary>
        //[Display(Name = "Product Name", Description = ""),
        //StringLength(255, ErrorMessage = "Product Name cannot be more than 255 characters")]
        //public Boolean NeedStockStatus
        //{
        //    get { return GetProperty(NeedStockStatusProperty); }
        //    set { SetProperty(ProductNameProperty, value); }
        //}

        //public int InventoryQuantity { get; set; }

        #endregion

        #region " Methods "

        protected override object GetIdValue()
        {
            return GetProperty(ProductIDProperty);
        }

        public override string ToString()
        {
            if (this.ProductName.Length == 0)
            {
                if (this.IsNew)
                {
                    return String.Format("New {0}", "Product");
                }
                else
                {
                    return String.Format("Blank {0}", "Product");
                }
            }
            else
            {
                return this.ProductName;
            }
        }

        #endregion

        #endregion

        #region " Validation Rules "

        protected override void AddBusinessRules()
        {
            base.AddBusinessRules();
        }

        #endregion

        #region " Data Access & Factory Methods "

        protected override void OnCreate()
        {
            // This is called when a new object is created
            // Set any variables here, not in the constructor or NewProduct() method.
        }

       // private int[] qty = {1,2,3,4,5,6,7,8,9 };
        
        public static Product NewProduct()
        {
            return DataPortal.CreateChild<Product>();
        }

        public Product()
        {
            

            MarkAsChild();
        }

        internal static Product GetProduct(SafeDataReader dr)
        {
           

            var p = new Product();
            p.Fetch(dr);
            return p;
        }

        protected void Fetch(SafeDataReader sdr)
        {
            using (BypassPropertyChecks)
            {
                int i = 0;
                LoadProperty(ProductIDProperty, sdr.GetInt32(i++));
                LoadProperty(CategoryIDProperty, Singular.Misc.ZeroNothing(sdr.GetInt32(i++)));
                LoadProperty(ProductNameProperty, sdr.GetString(i++));
                LoadProperty(ProductPriceProperty, sdr.GetDecimal(i++));
                LoadProperty(CreatedDateProperty, sdr.GetSmartDate(i++));
                LoadProperty(DeleteStatusProperty, sdr.GetValue(i++));
               

            }

            MarkAsChild();
            MarkOld();
            BusinessRules.CheckRules();
        }

        protected override Action<SqlCommand> SetupSaveCommand(SqlCommand cm)
        {
            AddPrimaryKeyParam(cm, ProductIDProperty);

            cm.Parameters.AddWithValue("@CategoryID", GetProperty(CategoryIDProperty));
            cm.Parameters.AddWithValue("@ProductName", GetProperty(ProductNameProperty));
            cm.Parameters.AddWithValue("@ProductPrice", GetProperty(ProductPriceProperty));
            cm.Parameters.AddWithValue("@DeleteStatus", GetProperty(DeleteStatusProperty));
          


            return (scm) =>
            {
    // Post Save
    if (this.IsNew)
                {
                    LoadProperty(ProductIDProperty, scm.Parameters["@ProductID"].Value);
                }
            };
        }

        protected override void SaveChildren()
        {
            // No Children
        }

        protected override void SetupDeleteCommand(SqlCommand cm)
        {
            cm.Parameters.AddWithValue("@ProductID", GetProperty(ProductIDProperty));
        }

        #endregion

    }

}