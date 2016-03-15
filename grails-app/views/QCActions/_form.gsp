<%@ page import="com.smanggin.trackingmanagement.QCActions" %>



			<div class="form-group fieldcontain ${hasErrors(bean: QCActionsInstance, field: 'serverId', 'error')} ">
				<label for="serverId" class="col-sm-3 control-label"><g:message code="QCActions.serverId.label" default="Server Id" /></label>
				<div class="col-sm-9">
					<g:textField name="serverId" class="form-control" value="${QCActionsInstance?.serverId}"/>
					<span class="help-inline">${hasErrors(bean: QCActionsInstance, field: 'serverId', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: QCActionsInstance, field: 'description', 'error')} ">
				<label for="description" class="col-sm-3 control-label"><g:message code="QCActions.description.label" default="Description" /></label>
				<div class="col-sm-9">
					<g:textField name="description" class="form-control" value="${QCActionsInstance?.description}"/>
					<span class="help-inline">${hasErrors(bean: QCActionsInstance, field: 'description', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: QCActionsInstance, field: 'updatedBy', 'error')} ">
				<label for="updatedBy" class="col-sm-3 control-label"><g:message code="QCActions.updatedBy.label" default="Updated By" /></label>
				<div class="col-sm-9">
					<g:textField name="updatedBy" class="form-control" value="${QCActionsInstance?.updatedBy}"/>
					<span class="help-inline">${hasErrors(bean: QCActionsInstance, field: 'updatedBy', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: QCActionsInstance, field: 'createdBy', 'error')} ">
				<label for="createdBy" class="col-sm-3 control-label"><g:message code="QCActions.createdBy.label" default="Created By" /></label>
				<div class="col-sm-9">
					<g:textField name="createdBy" class="form-control" value="${QCActionsInstance?.createdBy}"/>
					<span class="help-inline">${hasErrors(bean: QCActionsInstance, field: 'createdBy', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: QCActionsInstance, field: 'qCHeaders', 'error')} ">
				<label for="qCHeaders" class="col-sm-3 control-label"><g:message code="QCActions.qCHeaders.label" default="QCH eaders" /></label>
				<div class="col-sm-9">
					
<ul class="one-to-many">
<g:each in="${QCActionsInstance?.qCHeaders?}" var="q">
    <li><g:link controller="QCHeader" action="show" id="${q.id}">${q?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="QCHeader" action="create" params="['QCActions.id': QCActionsInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'QCHeader.label', default: 'QCHeader')])}</g:link>
</li>
</ul>

					<span class="help-inline">${hasErrors(bean: QCActionsInstance, field: 'qCHeaders', 'error')}</span>
				</div>
			</div>



