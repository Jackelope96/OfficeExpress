using System;
using Singular;
using Singular.Web.Security;

namespace OETLib.Security
{
  /// <summary>
  /// OETWebSecurity class
  /// </summary>
  [Serializable]
  public class OETWebSecurity: WebSecurity<WebPrinciple<OETIdentity>, OETIdentity>
  {
    /// <summary>
    /// Generate a hash for a password
    /// </summary>
    /// <param name="plainTextPassword">The password to hash</param>
    /// <returns>The hashed password</returns>
    public static string GetPasswordHash(string plainTextPassword)
    {
      return Encryption.GetStringHash(plainTextPassword, Encryption.HashType.Sha256);
    }
  }
}
