<%@ page import="com.smanggin.trackingmanagement.TransactionGroup" %>

			<div class="form-group fieldcontain ${hasErrors(bean: transactionGroupInstance, field: 'transactionType', 'error')} required">
				<label for="transactionType" class="col-sm-3 control-label"><g:message code="transactionGroup.transactionType.label" default="Transaction Type" /><span class="required-indicator">*</span></label>
				<div class="col-sm-3">
					<g:select id="transactionType" name="transactionType" from="${[[id:0,value:'Production in'],[id:1,id:0,value:'QC']]}" optionKey="id" optionValue="value" required="" value="${transactionGroupInstance?.transactionType}"  noSelection="${['':'']}" class="many-to-one form-control chosen-select-width"/>
					<span class="help-inline">${hasErrors(bean: transactionGroupInstance, field: 'transactionType', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: transactionGroupInstance, field: 'name', 'error')} ">
				<label for="name" class="col-sm-3 control-label"><g:message code="transactionGroup.name.label" default="name" /><span class="required-indicator">*</span></label>
				<div class="col-sm-5">
					<g:textField name="name" class="form-control" value="${transactionGroupInstance?.name}" required=""/>
					<span class="help-inline">${hasErrors(bean: transactionGroupInstance, field: 'name', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: transactionGroupInstance, field: 'numberingMethod', 'error')} ">
				<label for="numberingMethod" class="col-sm-3 control-label"><g:message code="transactionGroup.numberingMethod.label" default="Format" /><span class="required-indicator">*</span></label>
				<div class="col-sm-5">
					<g:select id="numberingMethod" name="numberingMethod" from="${['YYYY','YYMM']}"  required="" value="${transactionGroupInstance?.numberingMethod}" class="many-to-one form-control chosen-select-width"  noSelection="${['':'']}" />
					<span class="help-inline">${hasErrors(bean: transactionGroupInstance, field: 'numberingMethod', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: transactionGroupInstance, field: 'prefix', 'error')} ">
				<label for="prefix" class="col-sm-3 control-label"><g:message code="transactionGroup.prefix.label" default="Prefix" /><span class="required-indicator">*</span></label>
				<div class="col-sm-5">
					<g:textField name="prefix" class="form-control" value="${transactionGroupInstance?.prefix}" required=""/>
					<span class="help-inline">${hasErrors(bean: transactionGroupInstance, field: 'prefix', 'error')}</span>
				</div>
			</div>

			
			<div class="form-group fieldcontain ${hasErrors(bean: transactionGroupInstance, field: 'width', 'error')} required">
				<label for="width" class="col-sm-3 control-label"><g:message code="transactionGroup.width.label" default="Width" /><span class="required-indicator">*</span></label>
				<div class="col-sm-5">
					<g:field type="number" class="form-control"  name="width" required="" value="${transactionGroupInstance.width}"/>
					<span class="help-inline">${hasErrors(bean: transactionGroupInstance, field: 'width', 'error')}</span>
				</div>
			</div>

			<div class="form-group ${hasErrors(bean: transactionGroupInstance, field: 'plant', 'error')}  required">
				<label for="plant" class="col-sm-3 control-label"><g:message code="register.plant.label" default="Country" /></label>
				<div class="col-sm-3">
					<g:select id="plant" name="plant.serverId" from="${com.smanggin.trackingmanagement.Plant.list()}" optionKey="serverId" optionValue="name" required="" value="${transactionGroupInstance?.plant?.id}" class="many-to-one form-control chosen-select" />
					<span class="help-inline">${hasErrors(bean: transactionGroupInstance, field: 'plant', 'error')}</span>
				</div>
			</div>
			



