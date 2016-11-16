<%@ page import="com.smanggin.trackingmanagement.ReceiveItem" %>
			
			<div class="form-group fieldcontain ${hasErrors(bean: receiveItemInstance, field: 'transactionGroup', 'error')} required">
				<label for="transactionGroup" class="col-sm-3 control-label"><g:message code="qcAfkir.transactionGroup.label" default="Transaction Group" /><span class="required-indicator">*</span></label>
				<div class="col-sm-9">
					<g:select id="transactionGroup" name="transactionGroup.serverId" from="${trGroupList}" optionKey="serverId" required="" value="${receiveItemInstance?.transactionGroup?.serverId}" class="many-to-one form-control chosen-select"/>
					<span class="help-inline">${hasErrors(bean: receiveItemInstance, field: 'transactionGroup', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: receiveItemInstance, field: 'reffNo', 'error')} ">
				<label for="number" class="col-sm-3 control-label"><g:message code="receiveItem.reffNo.label" default="reffNo" /></label>
				<div class="col-sm-9">
					<g:textField name="reffNo" class="form-control" value="${receiveItemInstance?.reffNo}"/>
					<span class="help-inline">${hasErrors(bean: receiveItemInstance, field: 'reffNo', 'error')}</span>
				</div>
			</div>


			<div class="form-group fieldcontain ${hasErrors(bean: receiveItemInstance, field: 'supplier', 'error')} required">
				<label for="supplier" class="col-sm-3 control-label"><g:message code="receiveItem.supplier.label" default="Supplier" /><span class="required-indicator">*</span></label>
				<div class="col-sm-9">
					<g:select id="supplier" name="supplier.serverId" from="${com.smanggin.trackingmanagement.Supplier.list()}" optionKey="serverId" required="" value="${receiveItemInstance?.supplier?.serverId}" class="many-to-one form-control chosen-select"/>
					<span class="help-inline">${hasErrors(bean: receiveItemInstance, field: 'supplier', 'error')}</span>
				</div>
			</div>
			
			<div class="form-group fieldcontain ${hasErrors(bean: receiveItemInstance, field: 'item', 'error')} required">
				<label for="item" class="col-sm-3 control-label"><g:message code="receiveItem.item.label" default="Tracked Item" /><span class="required-indicator">*</span></label>
				<div class="col-sm-5">
					<g:select id="item" name="item.serverId" from="${com.smanggin.trackingmanagement.Item.list()}" optionKey="serverId" required="" value="${receiveItemInstance?.item?.serverId?:session.defaultItemId}" class="many-to-one form-control chosen-select"/>
					<span class="help-inline">${hasErrors(bean: receiveItemInstance, field: 'item', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: receiveItemInstance, field: 'shift', 'error')} required">
				<label for="shift" class="col-sm-3 control-label"><g:message code="receiveItem.shift.label" default="Shift" /><span class="required-indicator">*</span></label>
				<div class="col-sm-9">
					<g:field type="number" name="shift" class="form-control" required="" value="${receiveItemInstance.shift}"/>
					<span class="help-inline">${hasErrors(bean: receiveItemInstance, field: 'shift', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: receiveItemInstance, field: 'groupShift', 'error')} ">
				<label for="groupShift" class="col-sm-3 control-label"><g:message code="receiveItem.groupShift.label" default="Group Shift" /></label>
				<div class="col-sm-9">
					<g:textField name="groupShift" class="form-control" value="${receiveItemInstance?.groupShift}"/>
					<span class="help-inline">${hasErrors(bean: receiveItemInstance, field: 'groupShift', 'error')}</span>
				</div>
			</div>



			<div class="form-group fieldcontain ${hasErrors(bean: receiveItemInstance, field: 'receivedDate', 'error')} required">
				<label for="receivedDate" class="col-sm-3 control-label"><g:message code="receiveItem.receivedDate.label" default="Received Date" /><span class="required-indicator">*</span></label>
				<div class="col-sm-9">
					<bs:datePicker name="receivedDate" precision="day"  value="${receiveItemInstance?.receivedDate}"  />
					<span class="help-inline">${hasErrors(bean: receiveItemInstance, field: 'receivedDate', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: receiveItemInstance, field: 'productionDate', 'error')} required">
				<label for="productionDate" class="col-sm-3 control-label"><g:message code="receiveItem.productionDate.label" default="Production Date" /><span class="required-indicator">*</span></label>
				<div class="col-sm-9">
					<bs:datePicker name="productionDate" precision="day"  value="${receiveItemInstance?.productionDate}"  />
					<span class="help-inline">${hasErrors(bean: receiveItemInstance, field: 'productionDate', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: receiveItemInstance, field: 'productionLine', 'error')} required">
				<label for="productionLine" class="col-sm-3 control-label"><g:message code="receiveItem.productionLine.label" default="Production Line" /><span class="required-indicator">*</span></label>
				<div class="col-sm-9">
					<g:field type="number" name="productionLine" class="form-control" required="" value="${receiveItemInstance.productionLine}"/>
					<span class="help-inline">${hasErrors(bean: receiveItemInstance, field: 'productionLine', 'error')}</span>
				</div>
			</div>

			

			<div class="form-group fieldcontain ${hasErrors(bean: receiveItemInstance, field: 'remarks', 'error')} ">
				<label for="remarks" class="col-sm-3 control-label"><g:message code="qcAfkir.remarks.label" default="Remaks" /></label>
				<div class="col-sm-9">
					<g:textArea name="remarks" class="form-control" value="${receiveItemInstance?.remarks}"/>
					<span class="help-inline">${hasErrors(bean: receiveItemInstance, field: 'remarks', 'error')}</span>
				</div>
			</div>

<r:script>
	$("#plant").on('change', function() {
		 $.ajax({
            url: "/${meta(name:'app.name')}/transactionGroup/jlist?plantId="+$(this).val()+"&trType=3",
            type: "POST",
            success: function (data) {
				
            	$('#transactionGroup').empty();
              	if(data.length > 0){
                    // $('#transactionGroup').prepend("<option value='' >All</option>")
                    $.each(data, function(a, b){	
                        var opt = "<option value='"+b.serverId+"'> "+ b.name +" </option>";
                        $('#transactionGroup').append(opt);
                     });
                     $('#transactionGroup').trigger('chosen:updated');
                }else{
                	$('#transactionGroup').chosen("destroy");
                	$('#transactionGroup').chosen();
                }
            },
            error: function (xhr, status, error) {
                alert("fail");
            }
        });
	});

	$(function() {
	    $("body").delegate(".datepicker", "focusin", function(){
	        $(this).datepicker();
	    });
	});


</r:script>			


