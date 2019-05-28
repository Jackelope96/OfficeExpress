function Save() {
  ViewModel.CallServerMethod('SaveSetting', { Setting: ViewModel.SystemSetting.Serialise(), SettingsType: ViewModel.SystemSetting().constructor.Type }, function (response) {
    if (response.MessageType) {
      Singular.AddMessage(response.MessageType - 1, "Save", response.Message).Fade(2000);
    } else {
      alert(response.ErrorText);
    }
  });
}