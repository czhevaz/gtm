<%@ page import="com.smanggin.trackingmanagement.QCHeader" %>
			<div class="form-group fieldcontain ${hasErrors(bean: QCHeaderInstance, field: 'number', 'error')} ">
				<label for="number" class="col-sm-3 control-label"><g:message code="QCHeader.number.label" default="Number" /></label>
				<div class="col-sm-5">
					<g:textField name="number" class="form-control" value="${QCHeaderInstance?.number}" readonly="true"/>
					<span class="help-inline">${hasErrors(bean: QCHeaderInstance, field: 'number', 'error')}</span>
				</div>
			</div>
			
			<div class="form-group fieldcontain ${hasErrors(bean: QCHeaderInstance, field: 'transactionGroup', 'error')} required">
				<label for="transactionGroup" class="col-sm-3 control-label"><g:message code="QCHeader.transactionGroup.label" default="Transaction Group" /><span class="required-indicator">*</span></label>
				<div class="col-sm-5">
					<g:select id="transactionGroup" name="transactionGroup.serverId" from="${transactionGroup}" optionKey="serverId" required="" value="${QCHeaderInstance?.transactionGroup?.serverId}" class="many-to-one form-control chosen-select"/>
					<span class="help-inline">${hasErrors(bean: QCHeaderInstance, field: 'transactionGroup', 'error')}</span>
				</div>
			</div>


			<div class="form-group fieldcontain ${hasErrors(bean: QCHeaderInstance, field: 'date', 'error')} required">
				<label for="date" class="col-sm-3 control-label"><g:message code="QCHeader.date.label" default="Date" /><span class="required-indicator">*</span></label>
				<div class="col-sm-5">
					<bs:datePicker name="date" precision="day"  value="${QCHeaderInstance?.date}"  />
					<span class="help-inline">${hasErrors(bean: QCHeaderInstance, field: 'date', 'error')}</span>
				</div>
			</div>

			
			<div class="form-group fieldcontain ${hasErrors(bean: QCHeaderInstance, field: 'plant', 'error')} required">
				<label for="plant" class="col-sm-3 control-label"><g:message code="QCHeader.plant.label" default="Plant" /><span class="required-indicator">*</span></label>
				<div class="col-sm-5">
					<g:select id="plant" name="plant.serverId" from="${com.smanggin.trackingmanagement.Plant.list()}" optionKey="serverId" required="" value="${QCHeaderInstance?.plant?.serverId}" class="many-to-one form-control chosen-select"/>
					<span class="help-inline">${hasErrors(bean: QCHeaderInstance, field: 'plant', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: QCHeaderInstance, field: 'shift', 'error')} required">
				<label for="shift" class="col-sm-3 control-label"><g:message code="QCHeader.plant.label" default="Shift" /><span class="required-indicator">*</span></label>
				<div class="col-sm-5">
					<g:select id="shift" name="shift.serverId" from="${com.smanggin.trackingmanagement.Shift.list()}" optionKey="serverId" required="" value="${QCHeaderInstance?.shift?.serverId}" class="many-to-one form-control chosen-select"/>
					<span class="help-inline">${hasErrors(bean: QCHeaderInstance, field: 'shift', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: QCHeaderInstance, field: 'item', 'error')} required">
				<label for="item" class="col-sm-3 control-label"><g:message code="QCHeader.plant.label" default="Tracked Item" /><span class="required-indicator">*</span></label>
				<div class="col-sm-5">
					<g:select id="item" name="item.serverId" from="${com.smanggin.trackingmanagement.Item.list()}" optionKey="serverId" required="" value="${QCHeaderInstance?.item?.serverId}" class="many-to-one form-control chosen-select"/>
					<span class="help-inline">${hasErrors(bean: QCHeaderInstance, field: 'item', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: QCHeaderInstance, field: 'workCenter', 'error')} required">
				<label for="workCenter" class="col-sm-3 control-label"><g:message code="QCHeader.workCenter.label" default="Work Center" /><span class="required-indicator">*</span></label>
				<div class="col-sm-5">
					<g:select id="workCenter" name="workCenter.serverId" from="${com.smanggin.trackingmanagement.WorkCenter.list()}" optionKey="serverId" required="" value="${QCHeaderInstance?.workCenter?.serverId}" class="many-to-one form-control chosen-select" />
					<span class="help-inline">${hasErrors(bean: QCHeaderInstance, field: 'workCenter', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: QCHeaderInstance, field: 'gallon', 'error')} required">
				<label for="gallon" class="col-sm-3 control-label"><g:message code="QCHeader.gallon.label" default="Gallon" /><span class="required-indicator">*</span></label>
				<div class="col-sm-5">
					<g:textField id="gallon" name="gallon.code" class="form-control" value="${QCHeaderInstance?.gallon?.code}" placeholder="Scan Gallon Barcode..." 
        style="width:98.5%;height:100px;font-size:20pt" onkeyUp="checkGallon();"/>
					<span class="help-inline">${hasErrors(bean: QCHeaderInstance, field: 'gallon', 'error')}</span>
				</div>
			</div>
			


<r:script>
	$(document).ready(function() {
        $("#Gallon").focus();
    });
    
    //checkGallon();
    /*var timernotif = 0;
    clearInterval(timernotif);
    timernotif = setInterval("checkGallon()", 2000);*/

    function checkGallon(){
    	var code = $("#gallon").val();
    	var workCenterId = $("#workCenter").val();
    	var itemId = $("#item").val();
        if (code) {
        	var data = {
        		workCenterId:workCenterId,
        		itemId:itemId,
        		code :code,
        		checkgalon:true,
        	}

        	$.ajax({
                url: "/${meta(name:'app.name')}/lineBalance/jlist",
                data: data,
                success: function (d) {
                    console.log(d);
                    if (d.success) {
	                    $('#createQC').removeClass('disabled');

                    } else {
    					$('#createQC').addClass('disabled');         
    					alert(' Item Code ' + code +'not Found in Balance' );           
                    }
                }
            });
        }
    }    
</r:script>

