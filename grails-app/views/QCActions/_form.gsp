<%@ page import="com.smanggin.trackingmanagement.QCActions" %>

			<div class="form-group fieldcontain ${hasErrors(bean: QCActionsInstance, field: 'code', 'error')} ">
				<label for="code" class="col-sm-3 control-label"><g:message code="QCActions.code.label" default="Code" /></label>
				<div class="col-sm-9">
					<g:textField name="code" class="form-control" value="${QCActionsInstance?.code}"/>
					<span class="help-inline">${hasErrors(bean: QCActionsInstance, field: 'description', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: QCActionsInstance, field: 'description', 'error')} ">
				<label for="description" class="col-sm-3 control-label"><g:message code="QCActions.description.label" default="Description" /></label>
				<div class="col-sm-9">
					<g:textArea class="form-control" name="description" value="${QCActionsInstance?.description}" rows="5" cols="40"/>
					
					<span class="help-inline">${hasErrors(bean: QCActionsInstance, field: 'description', 'error')}</span>
				</div>
			</div>

