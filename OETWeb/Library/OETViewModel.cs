using System;
using Singular.Web;

namespace OETWeb
{
  /// <summary>
  /// The OETStatelessViewModel class
  /// </summary>
  /// <typeparam name="ModelType"></typeparam>
  [Serializable]
  public class OETStatelessViewModel<ModelType>: StatelessViewModel<ModelType>
    where ModelType: StatelessViewModel<ModelType>
  {
  }
}
