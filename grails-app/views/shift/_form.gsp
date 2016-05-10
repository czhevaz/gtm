<%@ page import="com.smanggin.trackingmanagement.Shift" %>

			
			<div class="form-group fieldcontain ${hasErrors(bean: shiftInstance, field: 'name', 'error')} ">
				<label for="name" class="col-sm-3 control-label"><g:message code="shift.name.label" default="Name" /></label>
				<div class="col-sm-9">
					<g:textField name="name" class="form-control" value="${shiftInstance?.name}"/>
					<span class="help-inline">${hasErrors(bean: shiftInstance, field: 'name', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: shiftInstance, field: 'description', 'error')} ">
				<label for="description" class="col-sm-3 control-label"><g:message code="shift.description.label" default="Description" /></label>
				<div class="col-sm-9">
					<g:textField name="description" class="form-control" value="${shiftInstance?.description}"/>
					<span class="help-inline">${hasErrors(bean: shiftInstance, field: 'description', 'error')}</span>
				</div>
			</div>
			
			<div class="form-group fieldcontain">
                <label for="plant" class="col-sm-3 control-label">
                    <g:message code="productionInHeader.plant.label" default="Plant" />
                </label>
                <div class="col-sm-5">
                    <g:select id="plant" name="plant.serverId" readonly="true" from="${com.smanggin.trackingmanagement.Plant.list()}" optionKey="serverId" required="" value="${productionInHeaderInstance?.plant?.serverId}" class="many-to-one form-control chosen-select"/>
                </div>
            </div>


			<div class="form-group fieldcontain ${hasErrors(bean: shiftInstance, field: 'startDate', 'error')} required">
				<label for="startDate" class="col-sm-3 control-label"><g:message code="shift.startDate.label" default="Start Date" /><span class="required-indicator">*</span></label>
				<div class="col-sm-5">
					<div class="input-group bootstrap-timepicker timepicker">
	            		<input id="startDate" type="text" class="form-control input-small">
	            		
	            		<span class="input-group-addon"><i class="glyphicon glyphicon-time"></i></span>
	        		</div>
 					<span class="help-inline">${hasErrors(bean: shiftInstance, field: 'startDate', 'error')}</span>
				</div>
				<g:hiddenField name="startDate_hour" class="form-control" />
				<g:hiddenField name="startDate_minute" class="form-control" />
        
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: shiftInstance, field: 'endDate', 'error')} required">
				<label for="endDate" class="col-sm-3 control-label"><g:message code="shift.endDate.label" default="End Date" /><span class="required-indicator">*</span></label>
				<div class="col-sm-5">
					<div class="input-group bootstrap-timepicker timepicker">
	            		<input id="endDate" type="text" class="form-control input-small">
	            		
	            		<span class="input-group-addon"><i class="glyphicon glyphicon-time"></i></span>
	        		</div>			
					<span class="help-inline">${hasErrors(bean: shiftInstance, field: 'endDate', 'error')}</span>
				</div>
				<g:hiddenField name="endDate_hour" class="form-control" />
				<g:hiddenField name="endDate_minute" class="form-control" />
			</div>

			

		
<r:script>
            $('#startDate').timepicker({showMeridian:false}).on('changeTime.timepicker', function(e) {
            	$('#startDate_hour').val(e.time.hours);
            	$('#startDate_minute').val(e.time.minutes);
    console.log('The time is ' + e.time.value);
    console.log('The hour is ' + e.time.hours);
    console.log('The minute is ' + e.time.minutes);
    console.log('The meridian is ' + e.time.meridian);
  });
   $('#endDate').timepicker({showMeridian:false}).on('changeTime.timepicker', function(e) {
            	$('#endDate_hour').val(e.time.hours);
            	$('#endDate_minute').val(e.time.minutes);
    console.log('The time is ' + e.time.value);
    console.log('The hour is ' + e.time.hours);
    console.log('The minute is ' + e.time.minutes);
    console.log('The meridian is ' + e.time.meridian);
  });
        </r:script>


