<%@ page import="com.smanggin.trackingmanagement.ProductionInHeader" %>

	<div class="form-group fieldcontain ${hasErrors(bean: productionInHeaderInstance, field: 'date', 'error')} required">
		<label for="date" class="col-sm-3 control-label">
			<g:message code="productionInHeader.date.label" default="Date" />
			<span class="required-indicator">*</span>
		</label>
		<div class="col-sm-9">
			<bs:datePicker name="date" precision="day"  value="${productionInHeaderInstance?.date}"  />
			<span class="help-inline">${hasErrors(bean: productionInHeaderInstance, field: 'date', 'error')}</span>
		</div>
	</div>

	<div class="form-group fieldcontain ${hasErrors(bean: productionInHeaderInstance, field: 'number', 'error')} ">
		<label for="number" class="col-sm-3 control-label">
			<g:message code="productionInHeader.number.label" default="Number" />
		</label>
		<div class="col-sm-9">
			<g:textField name="number" class="form-control" value="${productionInHeaderInstance?.number}"/>
			<span class="help-inline">${hasErrors(bean: productionInHeaderInstance, field: 'number', 'error')}</span>
		</div>
	</div>

	<div class="form-group fieldcontain ${hasErrors(bean: productionInHeaderInstance, field: 'plant', 'error')} required">
		<label for="plant" class="col-sm-3 control-label">
			<g:message code="productionInHeader.plant.label" default="Plant" />
			<span class="required-indicator">*</span>
		</label>
		<div class="col-sm-9">
			<g:select id="plant" name="plant.serverId" from="${com.smanggin.trackingmanagement.Plant.list()}" optionKey="serverId" required="" value="${productionInHeaderInstance?.plant?.serverId}" class="many-to-one form-control chosen-select"/>
			<span class="help-inline">${hasErrors(bean: productionInHeaderInstance, field: 'plant', 'error')}</span>
		</div>
	</div>

	<div class="form-group fieldcontain ${hasErrors(bean: productionInHeaderInstance, field: 'totalGallon', 'error')} required">
		<label for="totalGallon" class="col-sm-3 control-label">
			<g:message code="productionInHeader.totalGallon.label" default="Total Gallon" />
			<span class="required-indicator">*</span>
		</label>
		<div class="col-sm-9">
			<g:field type="number" name="totalGallon" class="form-control" step="any" required="" value="${productionInHeaderInstance.totalGallon}"/>
			<span class="help-inline">${hasErrors(bean: productionInHeaderInstance, field: 'totalGallon', 'error')}</span>
		</div>
	</div>

	<div class="form-group fieldcontain ${hasErrors(bean: productionInHeaderInstance, field: 'transactionGroup', 'error')} required">
		<label for="transactionGroup" class="col-sm-3 control-label">
			<g:message code="productionInHeader.transactionGroup.label" default="Transaction Group" />
			<span class="required-indicator">*</span>
		</label>
		<div class="col-sm-9">
			<g:select id="transactionGroup" name="transactionGroup.serverId" from="${com.smanggin.trackingmanagement.TransactionGroup.list()}" optionKey="serverId" required="" value="${productionInHeaderInstance?.transactionGroup?.serverId}" class="many-to-one form-control chosen-select"/>
			<span class="help-inline">${hasErrors(bean: productionInHeaderInstance, field: 'transactionGroup', 'error')}</span>
		</div>
	</div>