﻿// Generated 18 Feb 2019 14:12 - Singular Systems Object Generator Version 2.2.699
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


namespace OETLib.Server
{
    [Serializable]
    public class ROProduct
     : SingularReadOnlyBase<ROProduct>
    {
        #region " Properties and Methods "

        #region " Properties "

        public static PropertyInfo<int> ProductIDProperty = RegisterProperty<int>(c => c.ProductID, "ID", 0);
        /// <summary>
        /// Gets the ID value
        /// </summary>
        [Display(AutoGenerateField = false), Key]
        public int ProductID
        {
            get { return GetProperty(ProductIDProperty); }
        }

        public static PropertyInfo<int?> CategoryIDProperty = RegisterProperty<int?>(c => c.CategoryID, "Category", null);
        /// <summary>
        /// Gets the Category value
        /// </summary>
        [Display(Name = "Category", Description = "")]
        public int? CategoryID
        {
            get { return GetProperty(CategoryIDProperty); }
        }

        public static PropertyInfo<string> ProductNameProperty = RegisterProperty<string>(c => c.ProductName, "Product Name", "");
        /// <summary>
        /// Gets the Product Name value
        /// </summary>
        [Display(Name = "Product Name", Description = "")]
        public string ProductName
        {
            get { return GetProperty(ProductNameProperty); }
        }

        public static PropertyInfo<decimal> ProductPriceProperty = RegisterProperty<decimal>(c => c.ProductPrice, "Product Price", (decimal)0);
        /// <summary>
        /// Gets the Product Price value
        /// </summary>
        [Display(Name = "Product Price", Description = "")]
        public decimal ProductPrice
        {
            get { return GetProperty(ProductPriceProperty); }
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

        #endregion

        #region " Methods "

        protected override object GetIdValue()
        {
            return GetProperty(ProductIDProperty);
        }

        public override string ToString()
        {
            return this.ProductName;
        }

        #endregion

        #endregion

        #region " Data Access & Factory Methods "

        internal static ROProduct GetROProduct(SafeDataReader dr)
        {
            var r = new ROProduct();
            r.Fetch(dr);
            return r;
        }

        protected void Fetch(SafeDataReader sdr)
        {
            int i = 0;
            LoadProperty(ProductIDProperty, sdr.GetInt32(i++));
            LoadProperty(CategoryIDProperty, Singular.Misc.ZeroNothing(sdr.GetInt32(i++)));
            LoadProperty(ProductNameProperty, sdr.GetString(i++));
            LoadProperty(ProductPriceProperty, sdr.GetDecimal(i++));
            LoadProperty(CreatedDateProperty, sdr.GetSmartDate(i++));
        }

        #endregion

    }

}