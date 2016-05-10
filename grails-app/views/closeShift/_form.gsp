<%@ page import="com.smanggin.trackingmanagement.CloseShift" %>
		
			<div class="form-group fieldcontain ${hasErrors(bean: closeShiftInstance, field: 'plant', 'error')} required">
				<label for="plant" class="col-sm-3 control-label"><g:message code="closeShift.plant.label" default="Plant" /><span class="required-indicator">*</span></label>
				<div class="col-sm-9">
					<g:select id="plant" name="plant.serverId" from="${com.smanggin.trackingmanagement.Plant.list()}" optionKey="serverId" required="" value="${closeShiftInstance?.plant?.serverId}" class="many-to-one form-control chosen-select"/>
					<span class="help-inline">${hasErrors(bean: closeShiftInstance, field: 'plant', 'error')}</span>
				</div>
			</div>


			<div class="form-group fieldcontain ${hasErrors(bean: closeShiftInstance, field: 'closeDate', 'error')} required">
				<label for="closeDate" class="col-sm-3 control-label"><g:message code="closeShift.closeDate.label" default="Close Date" /><span class="required-indicator">*</span></label>
				<div class="col-sm-9">
					<bs:datePicker name="closeDate" precision="day"  value="${closeShiftInstance?.closeDate}"  />
					<span class="help-inline">${hasErrors(bean: closeShiftInstance, field: 'closeDate', 'error')}</span>
				</div>
			</div>


			<div class="form-group fieldcontain ${hasErrors(bean: closeShiftInstance, field: 'shift', 'error')} required">
				<label for="shift" class="col-sm-3 control-label"><g:message code="closeShift.shift.label" default="Shift" /><span class="required-indicator">*</span></label>
				<div class="col-sm-9">
					<g:select id="shift" name="shift.serverId" from="${com.smanggin.trackingmanagement.Shift.list()}" optionKey="serverId" required="" value="${closeShiftInstance?.shift?.serverId}" class="many-to-one form-control chosen-select"/>
					<span class="help-inline">${hasErrors(bean: closeShiftInstance, field: 'shift', 'error')}</span>
				</div>
			</div>


			<div class="form-group fieldcontain ${hasErrors(bean: closeShiftInstance, field: 'line', 'error')} required">
				<label for="line" class="col-sm-3 control-label"><g:message code="closeShift.line.label" default="Line" /><span class="required-indicator">*</span></label>
				<div class="col-sm-9">
					<g:select id="line" name="line.serverId" from="${com.smanggin.trackingmanagement.Line.list()}" optionKey="serverId" required="" value="${closeShiftInstance?.line?.serverId}" class="many-to-one form-control chosen-select"/>
					<span class="help-inline">${hasErrors(bean: closeShiftInstance, field: 'line', 'error')}</span>
				</div>
			</div>

				
			<div class="form-group fieldcontain ${hasErrors(bean: closeShiftInstance, field: 'yieldBySystem', 'error')} required">
				<label for="yieldBySystem" class="col-sm-3 control-label"><g:message code="closeShift.yieldBySystem.label" default="Yield By System" /><span class="required-indicator">*</span></label>
				<div class="col-sm-9">
					<g:field type="number" name="yieldBySystem" step="any"  class="form-control" value="${closeShiftInstance.yieldBySystem}" class="col-sm-9"/>
					<span class="help-inline">${hasErrors(bean: closeShiftInstance, field: 'yieldBySystem', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: closeShiftInstance, field: 'yieldByUser', 'error')} required">
				<label for="yieldByUser" class="col-sm-3 control-label"><g:message code="closeShift.yieldByUser.label" default="Yield By User" /><span class="required-indicator">*</span></label>
				<div class="col-sm-9">
					<g:field type="number" name="yieldByUser" step="any" class="form-control" value="${closeShiftInstance.yieldByUser}" class="col-sm-9"/>
					<span class="help-inline">${hasErrors(bean: closeShiftInstance, field: 'yieldByUser', 'error')}</span>
				</div>
			</div>


<r:script>
		$('#line').on('change', function() {
			var lineID = $(this).val();
			var shiftID = $("#shift").val(); 
			$.ajax({
	            url: "/${meta(name:'app.name')}/lineBalance/jlist?closeshift=true",
	            data: {lineId: lineID, shiftId: shiftID},
	            type: "POST",
	            success: function (data) {
	            	console.log("data");
	            	console.log(data);
	            	$("#yieldBySystem").val(data.qty);
	            	$("#yieldByUser").val(data.qty);
	            	
	            },
	            error: function (xhr, status, error) {
	                alert("fail");
	            }
	        });
	  			
		});

		 
	</r:script>

