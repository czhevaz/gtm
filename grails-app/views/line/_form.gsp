<%@ page import="com.smanggin.trackingmanagement.Line" %>

			<div class="form-group fieldcontain ${hasErrors(bean: lineInstance, field: 'code', 'error')} required">
				<label for="code" class="col-sm-3 control-label"><g:message code="line.code.label" default="Code" /><span class="required-indicator">*</span></label>
				<div class="col-sm-9">
					<g:textField name="code" class="form-control" required="" value="${lineInstance?.code}"/>
					<span class="help-inline">${hasErrors(bean: lineInstance, field: 'code', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: lineInstance, field: 'name', 'error')} required">
				<label for="name" class="col-sm-3 control-label"><g:message code="line.name.label" default="Name" /><span class="required-indicator">*</span></label>
				<div class="col-sm-9">
					<g:textField name="name" class="form-control" required="" value="${lineInstance?.name}"/>
					<span class="help-inline">${hasErrors(bean: lineInstance, field: 'name', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: lineInstance, field: 'plant', 'error')} required">
				<label for="plant" class="col-sm-3 control-label"><g:message code="line.plant.label" default="Plant" /><span class="required-indicator">*</span></label>
				<div class="col-sm-9">
					<g:select id="plant" name="plant.serverId" from="${com.smanggin.trackingmanagement.Plant.list()}" optionKey="serverId" optionValue="code" required="" value="${lineInstance?.plant?.serverId}" class="many-to-one form-control chosen-select"/>
					<span class="help-inline">${hasErrors(bean: lineInstance, field: 'plant', 'error')}</span>
				</div>
			</div>