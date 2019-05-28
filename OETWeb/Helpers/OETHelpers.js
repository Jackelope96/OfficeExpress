
var OETHelpers = {

	Notification: function (Text, LayoutPosition, Type, Timeout) {
		var n = noty({
			text: Text,
			type: (Type) ? Type.toLowerCase() : 'information',
			dismissQueue: true,
			layout: LayoutPosition,
			theme: 'defaultTheme',
			timeout: (Timeout) ? Timeout : 3000
		});
	},

	QuestionDialogYesNo: function (Text, LayoutPosition, YesFunction, NoFunction) {
		var n = noty({
			text: Text,
			type: 'alert',
			dismissQueue: true,
			//layout: LayoutPosition,
			theme: 'defaultTheme',
			buttons: [
				{
					addClass: 'btn btn-primary', text: 'Yes', onClick: function ($noty) {
						$noty.close();
						YesFunction();
					}
				},
				{
					addClass: 'btn btn-danger', text: 'No', onClick: function ($noty) {
						$noty.close();
						NoFunction();
					}
				}
			]
		});
	},

	ErrorNotificationOk: function (Text, LayoutPosition, YesFunction) {
		var n = noty({
			text: Text,
			type: 'alert',
			dismissQueue: true,
			//layout: LayoutPosition,
			theme: 'defaultTheme',
			buttons: [
				{
					addClass: 'btn btn-primary', text: 'Ok', onClick: function ($noty) {
						$noty.close();
						YesFunction();
					}
				}

			]
		});
	}
}

var checkTheCheckBoxes = function () {
	var allTheCheckBoxes = $(".CheckBoxButton > input");

	for (var k = 0; k <= allTheCheckBoxes.length - 1; k++) {
		if (allTheCheckBoxes[k].value == "true") {
			$(allTheCheckBoxes[k].parentElement).addClass("active");
		}
	}
}


