<%@ page import="com.smanggin.trackingmanagement.QCHeader" %>



			<div class="form-group fieldcontain ${hasErrors(bean: QCHeaderInstance, field: 'updatedBy', 'error')} ">
				<label for="updatedBy" class="col-sm-3 control-label"><g:message code="QCHeader.updatedBy.label" default="Updated By" /></label>
				<div class="col-sm-9">
					<g:textField name="updatedBy" class="form-control" value="${QCHeaderInstance?.updatedBy}"/>
					<span class="help-inline">${hasErrors(bean: QCHeaderInstance, field: 'updatedBy', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: QCHeaderInstance, field: 'createdBy', 'error')} ">
				<label for="createdBy" class="col-sm-3 control-label"><g:message code="QCHeader.createdBy.label" default="Created By" /></label>
				<div class="col-sm-9">
					<g:textField name="createdBy" class="form-control" value="${QCHeaderInstance?.createdBy}"/>
					<span class="help-inline">${hasErrors(bean: QCHeaderInstance, field: 'createdBy', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: QCHeaderInstance, field: 'date', 'error')} required">
				<label for="date" class="col-sm-3 control-label"><g:message code="QCHeader.date.label" default="Date" /><span class="required-indicator">*</span></label>
				<div class="col-sm-9">
					<bs:datePicker name="date" precision="day"  value="${QCHeaderInstance?.date}"  />
					<span class="help-inline">${hasErrors(bean: QCHeaderInstance, field: 'date', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: QCHeaderInstance, field: 'gallon', 'error')} required">
				<label for="gallon" class="col-sm-3 control-label"><g:message code="QCHeader.gallon.label" default="Gallon" /><span class="required-indicator">*</span></label>
				<div class="col-sm-9">
					<g:select id="gallon" name="gallon.serverId" from="${com.smanggin.trackingmanagement.Gallon.list()}" optionKey="serverId" required="" value="${QCHeaderInstance?.gallon?.serverId}" class="many-to-one form-control chosen-select"/>
					<span class="help-inline">${hasErrors(bean: QCHeaderInstance, field: 'gallon', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: QCHeaderInstance, field: 'number', 'error')} ">
				<label for="number" class="col-sm-3 control-label"><g:message code="QCHeader.number.label" default="Number" /></label>
				<div class="col-sm-9">
					<g:textField name="number" class="form-control" value="${QCHeaderInstance?.number}"/>
					<span class="help-inline">${hasErrors(bean: QCHeaderInstance, field: 'number', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: QCHeaderInstance, field: 'plant', 'error')} required">
				<label for="plant" class="col-sm-3 control-label"><g:message code="QCHeader.plant.label" default="Plant" /><span class="required-indicator">*</span></label>
				<div class="col-sm-9">
					<g:select id="plant" name="plant.serverId" from="${com.smanggin.trackingmanagement.Plant.list()}" optionKey="serverId" required="" value="${QCHeaderInstance?.plant?.serverId}" class="many-to-one form-control chosen-select"/>
					<span class="help-inline">${hasErrors(bean: QCHeaderInstance, field: 'plant', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: QCHeaderInstance, field: 'qcActions', 'error')} required">
				<label for="qcActions" class="col-sm-3 control-label"><g:message code="QCHeader.qcActions.label" default="Qc Actions" /><span class="required-indicator">*</span></label>
				<div class="col-sm-9">
					<g:select id="qcActions" name="qcActions.id" from="${com.smanggin.trackingmanagement.QCActions.list()}" optionKey="id" required="" value="${QCHeaderInstance?.qcActions?.id}" class="many-to-one form-control chosen-select"/>
					<span class="help-inline">${hasErrors(bean: QCHeaderInstance, field: 'qcActions', 'error')}</span>
				</div>
			</div>


			<div class="form-group fieldcontain ${hasErrors(bean: QCHeaderInstance, field: 'transactionGroup', 'error')} required">
				<label for="transactionGroup" class="col-sm-3 control-label"><g:message code="QCHeader.transactionGroup.label" default="Transaction Group" /><span class="required-indicator">*</span></label>
				<div class="col-sm-9">
					<g:select id="transactionGroup" name="transactionGroup.serverId" from="${com.smanggin.trackingmanagement.TransactionGroup.list()}" optionKey="serverId" required="" value="${QCHeaderInstance?.transactionGroup?.serverId}" class="many-to-one form-control chosen-select"/>
					<span class="help-inline">${hasErrors(bean: QCHeaderInstance, field: 'transactionGroup', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: QCHeaderInstance, field: 'workCenter', 'error')} required">
				<label for="workCenter" class="col-sm-3 control-label"><g:message code="QCHeader.workCenter.label" default="Work Center" /><span class="required-indicator">*</span></label>
				<div class="col-sm-9">
					<g:select id="workCenter" name="workCenter.serverId" from="${com.smanggin.trackingmanagement.WorkCenter.list()}" optionKey="serverId" required="" value="${QCHeaderInstance?.workCenter?.serverId}" class="many-to-one form-control chosen-select"/>
					<span class="help-inline">${hasErrors(bean: QCHeaderInstance, field: 'workCenter', 'error')}</span>
				</div>
			</div>



