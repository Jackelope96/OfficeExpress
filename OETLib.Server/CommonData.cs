using System;
using Singular.CommonData;

namespace OETLib
{
    // ToDo: OETCachedLists isn't recognised unless the class is moved
    // out of the CommonData class. Is this a problem?
    public class CommonData : CommonDataBase<OETLib.CommonData.OETCachedLists>
    {
        [Serializable]
        public class OETCachedLists : CommonDataBase<OETCachedLists>.CachedLists
        {
            public OETLib.BusinessObjects.Model.CategoryList CategoryList
            {
                get
                {
                    return RegisterList<OETLib.BusinessObjects.Model.CategoryList>(Misc.ContextType.Application, c => c.CategoryList, () => { return OETLib.BusinessObjects.Model.CategoryList.GetCategoryList(); });
                }
            }

            public OETLib.BusinessObjects.Model.ROUserList UserList
            {
                get
                {
                    return RegisterList<OETLib.BusinessObjects.Model.ROUserList>(Misc.ContextType.Application, c => c.UserList, () => { return OETLib.BusinessObjects.Model.ROUserList.GetROUserList(); });
                }
            }
            public OETLib.BusinessObjects.Model.myCartList myCartList
            {
                get
                {
                    return RegisterList<OETLib.BusinessObjects.Model.myCartList>(Misc.ContextType.Application, c => c.myCartList, () => { return OETLib.BusinessObjects.Model.myCartList.GetmyCartList(); });
                }
            }
        }
    }

  public class Enums
  {
  }
}
