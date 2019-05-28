$(document).ready(function () {

    (function ($) {

        $('#filter').keyup(function () {

            var rex = new RegExp($(this).val(), 'i');
            $('.searchable tr').hide();
            $('.searchable tr').filter(function () {
                return rex.test($(this).text());
            }).show();

        })

    }(jQuery));

});

//$(".dropzone").dropzone({
//	url: 'upload.php'
//})
// datatable sorting 
//$(document).ready(function () {
//	var dataSet = ["", "Wood ", "Architect", "F15", "36", "Feb, 15"];
//	dt = $('#example').DataTable({
//		colReorder: true,

//	});

//	$("#addData").on("click", function () {
//		dt.row.add(dataSet).draw(false);
//		dt.on('order.dt search.dt', function () {
//			dt.column(0, { search: 'applied', order: 'applied' }).nodes().each(function (cell, i) {
//				cell.innerHTML = i + 1;
//			});
//		}).draw();
//	});

//	$("tbody").sortable({
//		stop: function (event, ui) {
//			$(this).find('tr').each(function (i) {
//				$(this).find('td:first').text(i + 1);
//			});
//		}
//	});
//});


