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

			<div class="form-group fieldcontain ${hasErrors(bean: processInstance, field: 'updatedBy', 'error')} ">
				<label for="updatedBy" class="col-sm-3 control-label"><g:message code="process.updatedBy.label" default="Updated By" /></label>
				<div class="col-sm-9">
					<g:textField name="updatedBy" class="form-control" value="${processInstance?.updatedBy}"/>
					<span class="help-inline">${hasErrors(bean: processInstance, field: 'updatedBy', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: processInstance, field: 'createdBy', 'error')} ">
				<label for="createdBy" class="col-sm-3 control-label"><g:message code="process.createdBy.label" default="Created By" /></label>
				<div class="col-sm-9">
					<g:textField name="createdBy" class="form-control" value="${processInstance?.createdBy}"/>
					<span class="help-inline">${hasErrors(bean: processInstance, field: 'createdBy', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: processInstance, field: 'processQCs', 'error')} ">
				<label for="processQCs" class="col-sm-3 control-label"><g:message code="process.processQCs.label" default="Process QC s" /></label>
				<div class="col-sm-9">
					
<ul class="one-to-many">
<g:each in="${processInstance?.processQCs?}" var="p">
    <li><g:link controller="processQC" action="show" id="${p.id}">${p?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="processQC" action="create" params="['process.id': processInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'processQC.label', default: 'ProcessQC')])}</g:link>
</li>
</ul>

					<span class="help-inline">${hasErrors(bean: processInstance, field: 'processQCs', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: processInstance, field: 'workCenters', 'error')} ">
				<label for="workCenters" class="col-sm-3 control-label"><g:message code="process.workCenters.label" default="Work Centers" /></label>
				<div class="col-sm-9">
					
<ul class="one-to-many">
<g:each in="${processInstance?.workCenters?}" var="w">
    <li><g:link controller="workCenter" action="show" id="${w.id}">${w?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="workCenter" action="create" params="['process.id': processInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'workCenter.label', default: 'WorkCenter')])}</g:link>
</li>
</ul>

					<span class="help-inline">${hasErrors(bean: processInstance, field: 'workCenters', 'error')}</span>
				</div>
			</div>



