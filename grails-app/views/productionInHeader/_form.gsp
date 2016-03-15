<%@ page import="com.smanggin.trackingmanagement.ProductionInHeader" %>



			<div class="form-group fieldcontain ${hasErrors(bean: productionInHeaderInstance, field: 'updatedBy', 'error')} ">
				<label for="updatedBy" class="col-sm-3 control-label"><g:message code="productionInHeader.updatedBy.label" default="Updated By" /></label>
				<div class="col-sm-9">
					<g:textField name="updatedBy" class="form-control" value="${productionInHeaderInstance?.updatedBy}"/>
					<span class="help-inline">${hasErrors(bean: productionInHeaderInstance, field: 'updatedBy', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: productionInHeaderInstance, field: 'createdBy', 'error')} ">
				<label for="createdBy" class="col-sm-3 control-label"><g:message code="productionInHeader.createdBy.label" default="Created By" /></label>
				<div class="col-sm-9">
					<g:textField name="createdBy" class="form-control" value="${productionInHeaderInstance?.createdBy}"/>
					<span class="help-inline">${hasErrors(bean: productionInHeaderInstance, field: 'createdBy', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: productionInHeaderInstance, field: 'date', 'error')} required">
				<label for="date" class="col-sm-3 control-label"><g:message code="productionInHeader.date.label" default="Date" /><span class="required-indicator">*</span></label>
				<div class="col-sm-9">
					<bs:datePicker name="date" precision="day"  value="${productionInHeaderInstance?.date}"  />
					<span class="help-inline">${hasErrors(bean: productionInHeaderInstance, field: 'date', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: productionInHeaderInstance, field: 'number', 'error')} ">
				<label for="number" class="col-sm-3 control-label"><g:message code="productionInHeader.number.label" default="Number" /></label>
				<div class="col-sm-9">
					<g:textField name="number" class="form-control" value="${productionInHeaderInstance?.number}"/>
					<span class="help-inline">${hasErrors(bean: productionInHeaderInstance, field: 'number', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: productionInHeaderInstance, field: 'plant', 'error')} required">
				<label for="plant" class="col-sm-3 control-label"><g:message code="productionInHeader.plant.label" default="Plant" /><span class="required-indicator">*</span></label>
				<div class="col-sm-9">
					<g:select id="plant" name="plant.id" from="${com.smanggin.trackingmanagement.Plant.list()}" optionKey="id" required="" value="${productionInHeaderInstance?.plant?.id}" class="many-to-one form-control chosen-select"/>
					<span class="help-inline">${hasErrors(bean: productionInHeaderInstance, field: 'plant', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: productionInHeaderInstance, field: 'productionInDetails', 'error')} ">
				<label for="productionInDetails" class="col-sm-3 control-label"><g:message code="productionInHeader.productionInDetails.label" default="Production In Details" /></label>
				<div class="col-sm-9">
					
<ul class="one-to-many">
<g:each in="${productionInHeaderInstance?.productionInDetails?}" var="p">
    <li><g:link controller="productionInDetail" action="show" id="${p.id}">${p?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="productionInDetail" action="create" params="['productionInHeader.id': productionInHeaderInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'productionInDetail.label', default: 'ProductionInDetail')])}</g:link>
</li>
</ul>

					<span class="help-inline">${hasErrors(bean: productionInHeaderInstance, field: 'productionInDetails', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: productionInHeaderInstance, field: 'serverId', 'error')} ">
				<label for="serverId" class="col-sm-3 control-label"><g:message code="productionInHeader.serverId.label" default="Server Id" /></label>
				<div class="col-sm-9">
					<g:textField name="serverId" class="form-control" value="${productionInHeaderInstance?.serverId}"/>
					<span class="help-inline">${hasErrors(bean: productionInHeaderInstance, field: 'serverId', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: productionInHeaderInstance, field: 'totalGallon', 'error')} required">
				<label for="totalGallon" class="col-sm-3 control-label"><g:message code="productionInHeader.totalGallon.label" default="Total Gallon" /><span class="required-indicator">*</span></label>
				<div class="col-sm-9">
					<g:field type="number" name="totalGallon" step="any" required="" value="${productionInHeaderInstance.totalGallon}"/>
					<span class="help-inline">${hasErrors(bean: productionInHeaderInstance, field: 'totalGallon', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: productionInHeaderInstance, field: 'transactionGroup', 'error')} required">
				<label for="transactionGroup" class="col-sm-3 control-label"><g:message code="productionInHeader.transactionGroup.label" default="Transaction Group" /><span class="required-indicator">*</span></label>
				<div class="col-sm-9">
					<g:select id="transactionGroup" name="transactionGroup.id" from="${com.smanggin.trackingmanagement.TransactionGroup.list()}" optionKey="id" required="" value="${productionInHeaderInstance?.transactionGroup?.id}" class="many-to-one form-control chosen-select"/>
					<span class="help-inline">${hasErrors(bean: productionInHeaderInstance, field: 'transactionGroup', 'error')}</span>
				</div>
			</div>



