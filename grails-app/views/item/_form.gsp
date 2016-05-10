<%@ page import="com.smanggin.trackingmanagement.Item" %>


			<div class="form-group fieldcontain ${hasErrors(bean: itemInstance, field: 'name', 'error')} ">
				<label for="name" class="col-sm-3 control-label"><g:message code="item.name.label" default="Name" /></label>
				<div class="col-sm-9">
					<g:textField name="name" class="form-control" value="${itemInstance?.name}"/>
					<span class="help-inline">${hasErrors(bean: itemInstance, field: 'name', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: itemInstance, field: 'description', 'error')} ">
				<label for="description" class="col-sm-3 control-label"><g:message code="item.description.label" default="Description" /></label>
				<div class="col-sm-9">
					<g:textField name="description" class="form-control" value="${itemInstance?.description}"/>
					<span class="help-inline">${hasErrors(bean: itemInstance, field: 'description', 'error')}</span>
				</div>
			</div>


			


