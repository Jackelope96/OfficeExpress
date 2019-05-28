using System;
using Singular;

namespace OETLib
{
  /// <summary>
  /// OETBusinessBase Class (Base class for business objects)
  /// </summary>
  /// <typeparam name="C">Type based on OETBusinessBase</typeparam>
  [Serializable]
  public class OETBusinessBase<C> : SingularBusinessBase<C>
    where C : OETBusinessBase<C>
  {
  }

  /// <summary> 
  /// OETBusinessListBase Class (Base class for business object lists)
  /// </summary>
  /// <typeparam name="T">Type based on OETBusinessListBase</typeparam>
  /// <typeparam name="C">Type based on OETBusinessBase</typeparam>
  [Serializable]
  public class OETBusinessListBase<T, C> : SingularBusinessListBase<T, C>
    where T : OETBusinessListBase<T, C>
    where C : OETBusinessBase<C>
  {
  }

  /// <summary>
  /// OETReadOnlyBase Class (Base class for read only business objects)
  /// </summary>
  /// <typeparam name="C">Type based on OETReadOnlyBase</typeparam>
  public class OETReadOnlyBase<C> : SingularReadOnlyBase<C>
    where C: OETReadOnlyBase<C>
  {
  }

  /// <summary>
  /// OETReadOnlyListBase Class (Base class for read only business object lists)
  /// </summary>
  /// <typeparam name="T">Type based on OETReadOnlyListBase</typeparam>
  /// <typeparam name="C">Type based on OETReadOnlyBase</typeparam>
  public class OETReadOnlyListBase<T, C> : SingularReadOnlyListBase<T, C>
    where T: OETReadOnlyListBase<T, C>
    where C: OETReadOnlyBase<C>
  {
  }
}
