<%@ page import="com.smanggin.trackingmanagement.QcAfkir" %>
			
			<div class="form-group fieldcontain ${hasErrors(bean: qcAfkirInstance, field: 'plant', 'error')} required">
				<label for="plant" class="col-sm-3 control-label"><g:message code="qcAfkir.plant.label" default="Plant" /><span class="required-indicator">*</span></label>
				<div class="col-sm-9">
					<g:select id="plant" name="plant.serverId" from="${com.smanggin.trackingmanagement.Plant.list()}" optionKey="serverId" required="" value="${qcAfkirInstance?.plant?.serverId?:session.defaultPlantId}" class="many-to-one form-control chosen-select"/>
					<span class="help-inline">${hasErrors(bean: qcAfkirInstance, field: 'plant', 'error')}</span>
				</div>
			</div>

			
			<div class="form-group fieldcontain ${hasErrors(bean: qcAfkirInstance, field: 'transactionGroup', 'error')} required">
				<label for="transactionGroup" class="col-sm-3 control-label"><g:message code="qcAfkir.transactionGroup.label" default="Transaction Group" /><span class="required-indicator">*</span></label>
				<div class="col-sm-9">
					<g:select id="transactionGroup" name="transactionGroup.serverId" from="${trGroupList}" optionKey="serverId" required="" value="${qcAfkirInstance?.transactionGroup?.serverId}" class="many-to-one form-control chosen-select"/>
					<span class="help-inline">${hasErrors(bean: qcAfkirInstance, field: 'transactionGroup', 'error')}</span>
				</div>
			</div>

			

			<div class="form-group fieldcontain ${hasErrors(bean: qcAfkirInstance, field: 'number', 'error')} ">
				<label for="number" class="col-sm-3 control-label"><g:message code="qcAfkir.number.label" default="Number" /></label>
				<div class="col-sm-9">
					<g:textField name="number" class="form-control" value="${qcAfkirInstance?.number}"/>
					<span class="help-inline">${hasErrors(bean: qcAfkirInstance, field: 'number', 'error')}</span>
				</div>
			</div>

			
			<div class="form-group fieldcontain ${hasErrors(bean: qcAfkirInstance, field: 'workCenter', 'error')} required">
				<label for="workCenter" class="col-sm-3 control-label"><g:message code="qcAfkir.workCenter.label" default="Work Center" /><span class="required-indicator">*</span></label>
				<div class="col-sm-9">
					<g:select id="workCenter" name="workCenter.serverId" from="${com.smanggin.trackingmanagement.WorkCenter.list()}" optionKey="serverId" required="" value="${qcAfkirInstance?.workCenter?.serverId}" class="many-to-one form-control chosen-select"/>
					<span class="help-inline">${hasErrors(bean: qcAfkirInstance, field: 'workCenter', 'error')}</span>
				</div>
			</div>

			
			<div class="form-group fieldcontain ${hasErrors(bean: qcAfkirInstance, field: 'date', 'error')} required">
				<label for="date" class="col-sm-3 control-label"><g:message code="qcAfkir.date.label" default="Date" /><span class="required-indicator">*</span></label>
				<div class="col-sm-9">
					<bs:datePicker name="date" precision="day"  value="${qcAfkirInstance?.date}"  />
					<span class="help-inline">${hasErrors(bean: qcAfkirInstance, field: 'date', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: qcAfkirInstance, field: 'shift', 'error')} ">
				<label for="shift" class="col-sm-3 control-label"><g:message code="qcAfkir.shift.label" default="Shift" /></label>
				<div class="col-sm-9">
					<g:select id="shift" name="shift.serverId" from="${com.smanggin.trackingmanagement.Shift.list()}" optionKey="serverId" value="${qcAfkirInstance?.shift?.serverId}" class="many-to-one form-control chosen-select" noSelection="['null': '']"/>
					<span class="help-inline">${hasErrors(bean: qcAfkirInstance, field: 'shift', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: qcAfkirInstance, field: 'item', 'error')} ">
				<label for="item" class="col-sm-3 control-label"><g:message code="qcAfkir.item.label" default="Item" /></label>
				<div class="col-sm-9">
					<g:select id="item" name="item.serverId" from="${com.smanggin.trackingmanagement.Item.list()}" optionKey="serverId" value="${qcAfkirInstance?.item?.serverId?:session.defaultItemId}" class="many-to-one form-control chosen-select" noSelection="['null': '']"/>
					<span class="help-inline">${hasErrors(bean: qcAfkirInstance, field: 'item', 'error')}</span>
				</div>
			</div>

			
			<div class="form-group fieldcontain ${hasErrors(bean: qcAfkirInstance, field: 'description', 'error')} ">
				<label for="description" class="col-sm-3 control-label"><g:message code="qcAfkir.description.label" default="Description" /></label>
				<div class="col-sm-9">
					<g:textArea name="description" class="form-control" value="${qcAfkirInstance?.description}"/>
					<span class="help-inline">${hasErrors(bean: qcAfkirInstance, field: 'description', 'error')}</span>
				</div>
			</div>

			

			<div class="form-group fieldcontain ${hasErrors(bean: qcAfkirInstance, field: 'qCQuestions', 'error')} required">
				<label for="qCQuestions" class="col-sm-3 control-label"><g:message code="qcAfkir.qCQuestions.label" default="QC Parameters" /><span class="required-indicator">*</span></label>
				<div class="col-sm-9">
					<g:select id="qCQuestions" name="qCQuestions.serverId" from="${com.smanggin.trackingmanagement.QCQuestions.list()}" optionKey="serverId" required="" value="${qcAfkirInstance?.qCQuestions?.serverId}" class="many-to-one form-control chosen-select"/>
					<span class="help-inline">${hasErrors(bean: qcAfkirInstance, field: 'qCQuestions', 'error')}</span>
				</div>
			</div>

			<g:if test ="qcAfkirInstance?.qCQuestions?.serverId">
			<div class="form-group fieldcontain ${hasErrors(bean: qcAfkirInstance, field: 'qCQuestions', 'error')} required">
				<label for="qcAnswer" class="col-sm-3 control-label"><g:message code="qcAfkir.qCAnswer.label" default="Actual Condition" /><span class="required-indicator">*</span></label>
				<div class="col-sm-9" id="answer">
					
				</div>
			</div>
			
			</g:if>


<r:script>
	$(document).ready(function() {
		var id = String($("#qCQuestions").val());
		getAnswer(id);
	});

	$("#qCQuestions" ).change(function () {
		var id = String($(this).val());
		getAnswer(id);
	});

	function getAnswer(id){
		$.ajax({
            url: "/${meta(name:'app.name')}/QCQuestions/jshow",
            data: {id:id},
            success: function (d) {
            console.log(d);
                $('div#answer').empty();
                var dom ='';
                if(d.QCQuestionsInstance.parameterType == 0){
                	dom += domTextarea(d.QCQuestionsInstance);
                }else if(d.QCQuestionsInstance.parameterType == 1){
                	dom += domSelect(d.QCQuestionsInstance);
                }else if(d.QCQuestionsInstance.parameterType == 2){
                	dom += domCheckbox(d.QCQuestionsInstance);
                }

                $('div#answer').append(dom);
            }
        });
	}

	function domSelect(data){
		var dom = '<select  name="option_'+ data.sequenceNo+'" class="many-to-one form-control chosen-select">'
		$.each(data.qCOptions,function(i,o){
           dom += '<option value="'+o.id+'" >'+o.name+'</option>';
        });

		dom += '</select>'

		return dom;
	}

	function domTextarea(data){
		var dom = '<textarea rows="4" name="option_'+ data.sequenceNo+'" value class="form-control" rows="5" cols="40"> </textarea>'
		return dom;
	}

	function domCheckbox(data){
		var dom ='';
		$.each(data.qCOptions,function(i,o){
           dom += '<div class="checkbox"><label><input type="checkbox" name="option_'+ data.sequenceNo+'" > '+o.name+'</label></div>';
        });
		return dom;
	}

	$("#plant").on('change', function() {
		 $.ajax({
            url: "/${meta(name:'app.name')}/transactionGroup/jlist?plantId="+$(this).val()+"&trType=${session.trType}",
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

</r:script>

