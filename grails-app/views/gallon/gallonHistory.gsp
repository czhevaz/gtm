<!doctype html>
<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="layout" content="kickstart" />
    <g:set var="entityName" value="${message(code: 'gallon.label', default: 'Gallon History')}" />
    <title>Gallon History</title>
</head>

<body>

<section id="show-QCHeader" class="first">

    <div class="row">
        <div class="col-sm-6">
            <div class="form-group fieldcontain">
                <label for="plant" class="col-sm-3 control-label">
                    <g:message code="gallon.plant.label" default="GallonID" />
                    <span class="required-indicator">*</span>
                </label>
                <div class="col-sm-3">
                    <g:select id="plant" name="plant.serverId" from="${com.smanggin.trackingmanagement.Plant.list()}" optionKey="serverId" required="" value="${QCHeaderInstance?.plant?.serverId}" class="many-to-one form-control chosen-select"/>
                    <span class="help-inline">
                        ${hasErrors(bean: gallonInstance, field: 'plant', 'error')}
                    </span>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-sm-6">
            <div class="form-group fieldcontain">
                <label for="startDate" class="col-sm-3 control-label">
                    <g:message code="gallon.start.date.label" default="Start Date" />
                    <span class="required-indicator">*</span>
                </label>

                <g:jqDatePicker name="starDate" precision="day"  value="${params.starDate}" data-date-format="yyyy-mm-dd" />
            </div>
        </div>
        <div class="col-sm-6">
            <div class="form-group fieldcontain">
                <label for="endDate" class="col-sm-3 control-label">
                    <g:message code="gallon.end.date.label" default="End Date" />
                    <span class="required-indicator">*</span>
                </label>
                <g:jqDatePicker name="endDate" precision="day"  value="${params.starDate}" data-date-format="yyyy-mm-dd" />
            </div>
        </div>
        <div class="clearfix"></div>
    </div>

    <div class="row">
        <div class="col-sm-6">
            <div class="form-actions">
                <button class="btn btn-primary" id="process">
                    <g:message code="default.button.process.label" default="process" />
                </button>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-sm-12 table-responsive">
            <table id="table-summary" class="table table-bordered table-striped  margin-top-medium">
                <thead>
                <tr>
                    <td>No</td>
                    <td>Date</td>
                    <td>Plant</td>
                    <td>Line</td>
                    <td>WorkCenter</td>
                    <td>In</td>
                    <td>Out</td>
                    <td>Cycle Time</td>
                </tr>
                </thead>
                <tbody>

                </tbody>
            </table>
        </div>
    </div>

    <div class="row">
        <div class="col-sm-12">
            <button class="btn btn-success pull-right">
                <span class="glyphicon .glyphicon-save"></span> Generate XLS
            </button>
            <button class="btn btn-success pull-right" style="margin-right: 5px;">
                <span class="glyphicon .glyphicon-open"></span> Generate PDF
            </button>
        </div>
    </div>


    <r:script>
		$("#process").on('click', function() {
			//alert('hello world');

			var startDate = $('#starDate_year').val() + "-" + $('#starDate_month').val() + "-" + $('#starDate_day').val()+ " 00:00:00";
			var endDate = $('#endDate_year').val() + "-" + $('#endDate_month').val() + "-" + $('#endDate_day').val()+ " 23:59:59";
			var plantServerId = $("#plant").val();

			var data = {
				startDate:startDate,
				endDate:endDate ,
				plantServerId:plantServerId
			}

			$.ajax({
	            url: "/${meta(name:'app.name')}/QCHeader/qcSummary",
	            data: data,
	            type: "POST",
	            success: function (data) {
	            	console.log(data);
	            	$("#table-summary tbody").html("");
	            	$.each(data.results , function(i,item) {
						var tr ="<tr>";
    tr += "<td > "+  i +" </td>";
    tr += "<td > "+  item.barcode +" </td>";
    tr += "<td > "+  item.date +" </td>";
    tr += "<td > "+  item.userCreated +" </td>";
    tr += "</tr>";

						$("#table-summary tbody").append(tr);
					});
	            },
	            error: function (xhr, status, error) {
	                alert("fail");
	            }
        	});
		});
    </r:script>
</section>

</body>

</html>
