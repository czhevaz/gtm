<!doctype html>
<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="layout" content="kickstart" />
    <g:set var="entityName" value="${message(code: 'QCHeader.label', default: 'Hasil Produksi')}" />
    <title>Line Balances</title>
</head>

<body>

<section id="show-QCHeader" class="first">

    <div class="row">
        <div class="col-sm-6">
            <div class="form-group fieldcontain">
                <label for="plant" class="col-sm-3 control-label">
                    <g:message code="QCHeader.plant.label" default="Plant" />
                    <span class="required-indicator">*</span>
                </label>
                <div class="col-sm-3">
                    <g:select id="plant" name="plant.serverId" from="${com.smanggin.trackingmanagement.Plant.list()}" optionKey="serverId" required="" value="${QCHeaderInstance?.plant?.serverId}" class="many-to-one form-control chosen-select"/>
                </div>
            </div>
        </div>

    </div>
    <div class="row">
        <div class="col-sm-6">
            <div class="form-group fieldcontain ${hasErrors(bean: QCHeaderInstance, field: 'line', 'error')} required">
                <label for="line" class="col-sm-3 control-label"><g:message code="QCHeader.line.label" default="Line" /><span class="required-indicator">*</span></label>
                <div class="col-sm-3">
                    <g:select id="line" name="line.serverId" from="${com.smanggin.trackingmanagement.Line.list()}" optionKey="serverId" required="" value="${QCHeaderInstance?.line?.serverId}" class="many-to-one form-control chosen-select"/>
                    <span class="help-inline">${hasErrors(bean: QCHeaderInstance, field: 'line', 'error')}</span>
                </div>
            </div>
        </div>

    </div>
    <div class="row">

        <div class="col-sm-6">
            <div class="form-group fieldcontain ${hasErrors(bean: purchaseOrderInstance, field: 'purchaseOrderDate', 'error')} required">
                <label for="purchaseOrderDate" class="col-sm-3 control-label"><g:message code="purchaseOrder.purchaseOrderDate.label" default="Start Date" /><span class="required-indicator">*</span></label>

                <g:jqDatePicker name="starDate" precision="day"  value="${params.starDate}" data-date-format="yyyy-mm-dd" />

            </div>


        </div><!--/.col-lg-12 -->
        <div class="col-sm-6">
            <div class="form-group fieldcontain ${hasErrors(bean: purchaseOrderInstance, field: 'purchaseOrderDate', 'error')} required">
                <label for="purchaseOrderDate" class="col-sm-3 control-label"><g:message code="purchaseOrder.purchaseOrderDate.label" default="End Date" /><span class="required-indicator">*</span></label>

                <g:jqDatePicker name="endDate" precision="day"  value="${params.starDate}" data-date-format="yyyy-mm-dd" />

            </div>


        </div><!--/.col-lg-12 -->
        <div class="clearfix"></div>

    </div><!--/.row -->
    <div class="row">
        <div class="col-sm-6">
            <div class="form-actions">
                <button class="btn btn-primary" id="process"><g:message code="default.button.process.label" default="process" /></button>
            </div>
        </div>

    </div>


    <div class="row">
        <div class="col-sm-12 table-responsive">
            <table id="table-summary" class="table table-bordered table-striped  margin-top-medium">
                <thead>
                <tr>
                    <td>No</td>
                    <td>Date Write Off</td>
                    <td> </td>
                    <td>In </td>
                    <td>Out</td>
                    <td>Ending</td>
                </tr>
                </thead>
                <tbody>

                </tbody>
            </table>
        </div>
    </div>

    <div class="row">
        <div class="col-sm-6 pull-right">
            <p class="lead">Summary</p>
            <div class="table-responsive">
                <table class="table">
                   
                    <tr style="width:50%">
                        <th>Begin:</th>
                        <td><span id='begin'>0</span></td>
                    </tr>
                    <tr>
                        <th>In:</th>
                        <td><span id='totalIn'>0</span></td>
                    </tr>
                   
                    <tr>
                        <th>Out:</th>
                        <td><span id='totalOut'>0</span></td>
                    </tr>
                   
                    <tr>
                        <th>Total:</th>
                        <td><span id='total'>0</span></td>
                    </tr>
                </table>
            </div>
        </div>
    </div>

    

    <r:script>
		$("#process").on('click', function() {
			//alert('hello world');

			var startDate = $('#starDate_year').val() + "-" + $('#starDate_month').val() + "-" + $('#starDate_day').val()+ " 00:00:00";
			var endDate = $('#endDate_year').val() + "-" + $('#endDate_month').val() + "-" + $('#endDate_day').val()+ " 23:59:59";
			var plantServerId = $("#plant").val();
			var lineServerId = $("#line").val();

			var data = {
				startDate:startDate,
				endDate:endDate ,
				plantServerId:plantServerId,
				line1ServerId:lineServerId,
			}

			$.ajax({
	            url: "/${meta(name:'app.name')}/QCDetail/lineBalance",
	            data: data,
	            type: "POST",
	            success: function (data) {
	            	console.log(data);
	            	$("#table-summary tbody").html("");
                    var totalIn = 0
                    var totalOut = 0
	            	$.each(data.results , function(i, lb) {
						var tr ="<tr>";
                            tr += "<td > "+  (i*1+1) +" </td>";
                            tr += "<td > "+  lb.date +" </td>";
                            tr += "<td > "+  lb.begin +" </td>";
                            tr += "<td > "+  lb.in +" </td>";
                            tr += "<td > "+  lb.out +" </td>";
                            tr += "<td > "+  lb.ending +" </td>";
                            tr += "</tr>";
						$("#table-summary tbody").append(tr);
                        totalIn = totalIn+lb.in;
                        totalOut = totalOut+lb.out; 
					});
                    var total = totalIn - totalOut
                    $("#begin").text(data.results[0].begin);
                    $("#totalIn").text(totalIn);
                    $("#totalOut").text(totalOut);
                    $("#total").text(total);
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
