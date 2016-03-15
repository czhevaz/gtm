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

			<div class="form-group fieldcontain ${hasErrors(bean: lineInstance, field: 'updatedBy', 'error')} ">
				<label for="updatedBy" class="col-sm-3 control-label"><g:message code="line.updatedBy.label" default="Updated By" /></label>
				<div class="col-sm-9">
					<g:textField name="updatedBy" class="form-control" value="${lineInstance?.updatedBy}"/>
					<span class="help-inline">${hasErrors(bean: lineInstance, field: 'updatedBy', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: lineInstance, field: 'createdBy', 'error')} ">
				<label for="createdBy" class="col-sm-3 control-label"><g:message code="line.createdBy.label" default="Created By" /></label>
				<div class="col-sm-9">
					<g:textField name="createdBy" class="form-control" value="${lineInstance?.createdBy}"/>
					<span class="help-inline">${hasErrors(bean: lineInstance, field: 'createdBy', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: lineInstance, field: 'lineBalances', 'error')} ">
				<label for="lineBalances" class="col-sm-3 control-label"><g:message code="line.lineBalances.label" default="Line Balances" /></label>
				<div class="col-sm-9">
					
<ul class="one-to-many">
<g:each in="${lineInstance?.lineBalances?}" var="l">
    <li><g:link controller="lineBalance" action="show" id="${l.id}">${l?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="lineBalance" action="create" params="['line.id': lineInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'lineBalance.label', default: 'LineBalance')])}</g:link>
</li>
</ul>

					<span class="help-inline">${hasErrors(bean: lineInstance, field: 'lineBalances', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: lineInstance, field: 'workCenters', 'error')} ">
				<label for="workCenters" class="col-sm-3 control-label"><g:message code="line.workCenters.label" default="Work Centers" /></label>
				<div class="col-sm-9">
					
<ul class="one-to-many">
<g:each in="${lineInstance?.workCenters?}" var="w">
    <li><g:link controller="workCenter" action="show" id="${w.id}">${w?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="workCenter" action="create" params="['line.id': lineInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'workCenter.label', default: 'WorkCenter')])}</g:link>
</li>
</ul>

					<span class="help-inline">${hasErrors(bean: lineInstance, field: 'workCenters', 'error')}</span>
				</div>
			</div>



