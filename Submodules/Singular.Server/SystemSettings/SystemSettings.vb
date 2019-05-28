﻿Imports System.Reflection
Imports Csla.Serialization

Namespace SystemSettings

  Public Module General

    Public Class EncryptedField
      Inherits Attribute

    End Class

    Public Class NullableField
      Inherits Attribute

    End Class

    Public Property EncryptTextHandler As Func(Of String, Object)

    Public Property DecryptByteTextHandler As Func(Of Byte(), String)
    Public Property DecryptStringTextHandler As Func(Of String, String)

    Friend SettingsTypeList As New List(Of Type)

    Public Sub RegisterSettingsClass(Of SettingsType As Singular.SystemSettings.ISettingsSection)()
      SettingsTypeList.Add(GetType(SettingsType))
    End Sub

    Public Sub RegisterSettingsClass(Of SettingsType As Singular.SystemSettings.ISettingsSection)(ForceRefetch As Boolean)
      SettingsTypeList.Add(GetType(SettingsType))
#If SILVERLIGHT = False Then
      GetSystemSetting(Of SettingsType)(ForceRefetch)
#End If
    End Sub

#If SILVERLIGHT Then

    ''' <summary>
    ''' Gets a list of all the registered system settings
    ''' </summary>
    Public Sub BeginGetAllSettings(ByVal CallBack As EventHandler(Of Csla.DataPortalResult(Of Objects.SystemSettingList)))

      Dim dp As New Csla.DataPortal(Of Objects.SystemSettingList)
      AddHandler dp.FetchCompleted, CallBack
      dp.BeginFetch()

    End Sub

    ''' <summary>
    ''' Gets the specified system setting section.
    ''' </summary>
    'Public Function GetSystemSetting(Of SettingsType As Singular.SystemSettings.ISettingsSection)() As SettingsType

    '  Return Objects.SystemSettingList.GetSystemSettingList(Of ISettingsSection)().FirstOrDefault.Settings

    'End Function

    'Public Sub GetSystemSetting(Of SettingsType As Singular.SystemSettings.ISettingsSection)(ByVal CallBack As EventHandler(Of Csla.DataPortalResult(Of SettingsType)))

    '  Dim dp As New Csla.DataPortal(Of SettingsType)
    '  AddHandler dp.FetchCompleted, CallBack
    '  dp.BeginFetch()

    'End Sub

#Else

    ''' <summary>
    ''' Gets a list of all the registered system settings
    ''' </summary>
    Public Function GetAllSettings() As Objects.SystemSettingList
      Return Objects.SystemSettingList.GetSystemSettingList
    End Function

    Private mCachedSettings As New Hashtable

    ''' <summary>
    ''' Gets the specified system setting section.
    ''' </summary>
    Public Function GetSystemSetting(Of ST As Singular.SystemSettings.ISettingsSection)(Optional Refetch As Boolean = False) As ST
      Return GetSystemSetting(GetType(ST), Refetch)
    End Function

    Public Function GetSystemSetting(SettingsType As Type, Optional Refetch As Boolean = False) As ISettingsSection
      SyncLock mCachedSettings
        Dim Setting As Singular.SystemSettings.ISettingsSection = If(Refetch, Nothing, mCachedSettings(SettingsType))
        If Setting Is Nothing Then
          Setting = Objects.SystemSettingList.GetSystemSettingList(SettingsType).FirstOrDefault.Settings
          mCachedSettings(SettingsType) = Setting
        End If
        Return Setting
      End SyncLock
    End Function

    ''' <summary>
    ''' Gets a setting value directly from the database, without fetching the entire settings class. Warning: Requires EXECUTE role on Fn Schema.
    ''' </summary>
    ''' <typeparam name="ST">Settings Class Type</typeparam>
    ''' <param name="SettingProperty">Property to be fetched</param>
    Public Function GetSettingValue(Of ST As Singular.SystemSettings.ISettingsSection)(SettingProperty As System.Linq.Expressions.Expression(Of Func(Of ST, Object))) As Object

      Dim SettingsClass As ST = Activator.CreateInstance(Of ST)()
      Dim MemberInfo = Singular.Reflection.GetMember(SettingProperty)

      Dim Value = Singular.CommandProc.GetDataValueFromQuery("SELECT Fn.GetSystemSettingValue(@Section, @Property)", {"@Section", "@Property"}, {SettingsClass.Name, MemberInfo.Name})

      If Not Singular.Misc.IsNullNothing(Value) Then
        SettingsClass.SetProperty(MemberInfo.Name, Value)
      End If

      If TypeOf MemberInfo Is PropertyInfo Then
        Return CType(MemberInfo, PropertyInfo).GetValue(SettingsClass, Nothing)
      ElseIf TypeOf MemberInfo Is MethodInfo Then
        Return CType(MemberInfo, MethodInfo).Invoke(SettingsClass, Nothing)
      Else
        Throw New Exception("Member must be a property or method.")
      End If

    End Function

    Public Sub ResetSettings(Of Type As Singular.SystemSettings.ISettingsSection)()
      ResetSettings(GetType(Type))
    End Sub

    Public Sub ResetSettings(Type As Type)
      SyncLock mCachedSettings
        mCachedSettings(Type) = Nothing
      End SyncLock
    End Sub

#End If

  End Module

  Public Interface ISettingsSection

    Property ReturnUnMaskedPassword As Boolean

    ReadOnly Property Name As String
    ReadOnly Property Description As String

    ReadOnly Property SecurityRole As String

#If SILVERLIGHT = False Then
    Sub SetProperty(PropertyName As String, Value As Object)
    Function GetProperty(PropertyInfo As PropertyInfo) As Object
#End If

  End Interface

  <Serializable()>
  Public MustInherit Class SettingsSection(Of SettingsType As SettingsSection(Of SettingsType))
    Inherits Singular.SingularBusinessBase(Of SettingsType)
    Implements ISettingsSection

    <System.ComponentModel.DataAnnotations.Display(AutoGenerateField:=False)>
    Public Property ReturnUnMaskedPassword As Boolean Implements ISettingsSection.ReturnUnMaskedPassword

    <System.ComponentModel.DataAnnotations.Display(AutoGenerateField:=False)>
    Public MustOverride ReadOnly Property Name As String Implements ISettingsSection.Name

    <System.ComponentModel.DataAnnotations.Display(AutoGenerateField:=False)>
    Public MustOverride ReadOnly Property Description As String Implements ISettingsSection.Description

    <System.ComponentModel.DataAnnotations.Display(AutoGenerateField:=False)>
    Public Overridable ReadOnly Property SecurityRole As String Implements ISettingsSection.SecurityRole
      Get
        Return ""
      End Get
    End Property

#If SILVERLIGHT Then

#Else

#Region " Transforms "

#Region " Base "

    <System.NonSerialized> Private mTransformList As New List(Of Transform)

    ''' <summary>
    ''' Allows complex data types to be converted to a format supported by sql server.
    ''' </summary>
    ''' <param name="TargetProperty">The property to apply the transform to</param>
    ''' <param name="LoadTransform">Convert when loading from the database. Parameter: Value from database</param>
    ''' <param name="SaveTransform">Convert when saving to the database.</param>
    ''' <remarks></remarks>
    Protected Sub RegisterTransform(TargetProperty As System.Linq.Expressions.Expression(Of System.Func(Of SettingsType, Object)), LoadTransform As Action(Of Object), SaveTransform As Func(Of Object))
      Dim newTF As New Transform
      newTF.TargetPropertyName = Singular.Reflection.GetMember(TargetProperty).Name
      newTF.LoadTransform = LoadTransform
      newTF.SaveTransform = SaveTransform
      Dim Tf = GetTransform(newTF.TargetPropertyName)

      If Tf IsNot Nothing Then
        Tf.LoadTransform = newTF.LoadTransform
        Tf.SaveTransform = newTF.SaveTransform
      Else
        mTransformList.Add(newTF)
      End If
    End Sub

    Private Function GetTransform(PropertyName As String) As Transform
      For Each tf As Transform In mTransformList
        If tf.TargetPropertyName = PropertyName Then
          Return tf
        End If
      Next
      Return Nothing
    End Function

    Friend Overloads Sub SetProperty(PropertyName As String, Value As Object) Implements ISettingsSection.SetProperty
      Dim pi = Singular.Reflection.GetProperty(Me.GetType, PropertyName)
      If pi IsNot Nothing AndAlso pi.CanWrite Then

        'Check if there is a transform
        Dim tf = GetTransform(PropertyName)
        If tf IsNot Nothing Then
          tf.LoadTransform.Invoke(Value)
        Else
          pi.SetValue(Me, Value, Nothing)
        End If
      End If
    End Sub

    Friend Overloads Function GetProperty(PropertyInfo As PropertyInfo) As Object Implements ISettingsSection.GetProperty
      Dim tf = GetTransform(PropertyInfo.Name)
      If tf IsNot Nothing Then
        Return tf.SaveTransform.Invoke()
      Else
        Return PropertyInfo.GetValue(Me, Nothing)
      End If
    End Function

    <Serializable()>
    Public Class Transform
      Public Property TargetPropertyName As String
      Public Property LoadTransform As Action(Of Object)
      Public Property SaveTransform As Func(Of Object)
    End Class

#End Region

#Region " Custom "


    ''' <summary>
    ''' Converts a file byte array to an image of the specified type. 
    ''' </summary>
    Protected Sub RegisterIDocumentProviderImageTransform(TargetProperty As System.Linq.Expressions.Expression(Of System.Func(Of SettingsType, Object)), ImgType As System.Drawing.Imaging.ImageFormat)

      Dim pi As PropertyInfo = Singular.Reflection.GetMember(TargetProperty)

      RegisterTransform(TargetProperty, Sub(o)
                                          'Load
                                          CType(pi.GetValue(Me, Nothing), Singular.Documents.IDocumentProvider).SetDocument(o, pi.Name & "." & ImgType.ToString.ToLower)
                                        End Sub,
                                        Function()
                                          'Save
                                          Dim bmp = System.Drawing.Bitmap.FromStream(New IO.MemoryStream(CType(pi.GetValue(Me, Nothing), Singular.Documents.IDocumentProvider).Document.Document))
                                          Dim Output As New IO.MemoryStream
                                          bmp.Save(Output, ImgType)
                                          Return Output.ToArray
                                        End Function)

    End Sub

#End Region

#End Region

    Public Sub SaveSelf()
      Dim SettingsList = Singular.SystemSettings.Objects.SystemSettingList.GetSystemSettingList(Of SettingsType)()
      SettingsList.FirstAndOnly.SetSettings(Me)
      SettingsList.PrepareToSave()
      SettingsList.Save()
    End Sub

#End If

  End Class

End Namespace


