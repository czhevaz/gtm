<%@ page import="com.smanggin.trackingmanagement.Process" %>

			<div class="form-group fieldcontain ${hasErrors(bean: processInstance, field: 'code', 'error')} required">
				<label for="code" class="col-sm-3 control-label"><g:message code="process.code.label" default="Code" /><span class="required-indicator">*</span></label>
				<div class="col-sm-9">
					<g:textField name="code" class="form-control" required="" value="${processInstance?.code}"/>
					<span class="help-inline">${hasErrors(bean: processInstance, field: 'code', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: processInstance, field: 'name', 'error')} required">
				<label for="name" class="col-sm-3 control-label"><g:message code="process.name.label" default="Name" /><span class="required-indicator">*</span></label>
				<div class="col-sm-9">
					<g:textField name="name" class="form-control" required="" value="${processInstance?.name}"/>
					<span class="help-inline">${hasErrors(bean: processInstance, field: 'name', 'error')}</span>
				</div>
			</div>


