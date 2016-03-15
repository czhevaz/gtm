<%@ page import="com.smanggin.trackingmanagement.ProductionInDetail" %>



			<div class="form-group fieldcontain ${hasErrors(bean: productionInDetailInstance, field: 'updatedBy', 'error')} ">
				<label for="updatedBy" class="col-sm-3 control-label"><g:message code="productionInDetail.updatedBy.label" default="Updated By" /></label>
				<div class="col-sm-9">
					<g:textField name="updatedBy" class="form-control" value="${productionInDetailInstance?.updatedBy}"/>
					<span class="help-inline">${hasErrors(bean: productionInDetailInstance, field: 'updatedBy', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: productionInDetailInstance, field: 'createdBy', 'error')} ">
				<label for="createdBy" class="col-sm-3 control-label"><g:message code="productionInDetail.createdBy.label" default="Created By" /></label>
				<div class="col-sm-9">
					<g:textField name="createdBy" class="form-control" value="${productionInDetailInstance?.createdBy}"/>
					<span class="help-inline">${hasErrors(bean: productionInDetailInstance, field: 'createdBy', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: productionInDetailInstance, field: 'gallon', 'error')} required">
				<label for="gallon" class="col-sm-3 control-label"><g:message code="productionInDetail.gallon.label" default="Gallon" /><span class="required-indicator">*</span></label>
				<div class="col-sm-9">
					<g:select id="gallon" name="gallon.id" from="${com.smanggin.trackingmanagement.Gallon.list()}" optionKey="id" required="" value="${productionInDetailInstance?.gallon?.id}" class="many-to-one form-control chosen-select"/>
					<span class="help-inline">${hasErrors(bean: productionInDetailInstance, field: 'gallon', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: productionInDetailInstance, field: 'productionInHeader', 'error')} required">
				<label for="productionInHeader" class="col-sm-3 control-label"><g:message code="productionInDetail.productionInHeader.label" default="Production In Header" /><span class="required-indicator">*</span></label>
				<div class="col-sm-9">
					<g:select id="productionInHeader" name="productionInHeader.id" from="${com.smanggin.trackingmanagement.ProductionInHeader.list()}" optionKey="id" required="" value="${productionInDetailInstance?.productionInHeader?.id}" class="many-to-one form-control chosen-select"/>
					<span class="help-inline">${hasErrors(bean: productionInDetailInstance, field: 'productionInHeader', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: productionInDetailInstance, field: 'serverId', 'error')} ">
				<label for="serverId" class="col-sm-3 control-label"><g:message code="productionInDetail.serverId.label" default="Server Id" /></label>
				<div class="col-sm-9">
					<g:textField name="serverId" class="form-control" value="${productionInDetailInstance?.serverId}"/>
					<span class="help-inline">${hasErrors(bean: productionInDetailInstance, field: 'serverId', 'error')}</span>
				</div>
			</div>



