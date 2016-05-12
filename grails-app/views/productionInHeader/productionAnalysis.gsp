<!doctype html>
<html>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'QCHeader.label', default: 'QCHeader')}" />
	<title>Production Resource Analysis</title>
</head>

<body>

<section id="show-QCHeader" class="first">
	
	<div class="row">
		<div class="col-sm-6">	
		<div class="form-group fieldcontain ${hasErrors(bean: QCHeaderInstance, field: 'process', 'error')} required">
				<label for="plant" class="col-sm-3 control-label"><g:message code="QCHeader.process.label" default="Process" /><span class="required-indicator">*</span></label>
				<div class="col-sm-5">
					<g:select id="process" name="process.serverId" from="${com.smanggin.trackingmanagement.Process.list()}" optionKey="serverId" required="" value="${params?.process?.serverId}" class="many-to-one form-control chosen-select"/>
					<span class="help-inline">${hasErrors(bean: QCHeaderInstance, field: 'process', 'error')}</span>
				</div>
			</div>
		</div>	

	</div>
	<div class="row">
		<div class="col-sm-6">	
		<div class="form-group fieldcontain ${hasErrors(bean: QCHeaderInstance, field: 'plant', 'error')} required">
				<label for="plant" class="col-sm-3 control-label"><g:message code="QCHeader.plant.label" default="Plant" /><span class="required-indicator">*</span></label>
				<div class="col-sm-5">
					<g:select id="plant" name="plant.serverId" from="${com.smanggin.trackingmanagement.Plant.list()}" optionKey="serverId" required="" value="${QCHeaderInstance?.plant?.serverId}" class="many-to-one form-control chosen-select"/>
					<span class="help-inline">${hasErrors(bean: QCHeaderInstance, field: 'plant', 'error')}</span>
				</div>
			</div>
		</div>	

	</div>
	<div class="row">
		<div class="col-sm-6">	
		<div class="form-group fieldcontain ${hasErrors(bean: QCHeaderInstance, field: 'line', 'error')} required">
				<label for="line" class="col-sm-3 control-label"><g:message code="QCHeader.line.label" default="Line" /><span class="required-indicator">*</span></label>
				<div class="col-sm-5">
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
            <label for="purchaseOrderDate" class="col-sm-3 control-label"><g:message code="purchaseOrder.purchaseOrderDate.label" default="end Date" /><span class="required-indicator">*</span></label>
            
               <g:jqDatePicker name="endDate" precision="day"  value="${params.starDate}" data-date-format="yyyy-mm-dd" />
            
        </div>
        
			
		</div><!--/.col-lg-12 -->
		<div class="clearfix"></div>
		
	</div><!--/.row -->
	<div class="row">
		<div class="col-sm-6">	
			<div class="form-actions">	
				  <button class="btn btn-primary" id="processButton"><g:message code="default.button.process.label" default="process" /></button>
			</div>
		</div>	

	</div>


	<div class="row" id="div-summary">
		<table id="table-summary" class="table table-bordered table-striped  margin-top-medium">
			<thead>
				<tr>
					<td>No</td>
					<td>Workcenter</td>
					<td>Sum Tracked item</td>
					<td>Failed</td>
					<td>Yield</td>
					<td>Unknown</td>
					
				</tr>
			</thead>
			<tbody>
			
			</tbody>
		</table>
	</div>


	<r:script>
		$("#processButton").on('click', function() {
			
			   
			var startDate = $('#starDate_year').val() + "-" + $('#starDate_month').val() + "-" + $('#starDate_day').val()+ " 00:00:00";
			var endDate = $('#endDate_year').val() + "-" + $('#endDate_month').val() + "-" + $('#endDate_day').val()+ " 23:59:59";
			var plantServerId = $("#plant").val();
			var lineServerId = $("#line").val();
			var processServerId = $("#process").val();
			
			var data = {
				startDate:startDate,
				endDate:endDate ,
				plantServerId:plantServerId,
				line1ServerId:lineServerId,
				processServerId:processServerId
			}

			$.ajax({
	            url: "/${meta(name:'app.name')}/productionInHeader/productionAnalysis",
	            data: data,
	            type: "POST",
	            success: function (data) {
	            	console.log(data);
	            	$("#table-summary tbody").html("");
	            	$.each(data.results , function(i,item) {
	            		var tr ="<tr>";
	            		
							tr += "<td > "+  (i*1+1) +" </td>";
							tr += "<td > "+  item.workCenterName +" </td>";
							tr += "<td > "+  item.sumItem +" </td>";
							tr += "<td > "+  item.failed+" </td>";
							tr += "<td > "+  item.yield +" </td>";
							tr += "<td > "+  item.unknown +" </td>";
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
