<%@ page import="com.smanggin.trackingmanagement.WorkCenter" %>



			<div class="form-group fieldcontain ${hasErrors(bean: workCenterInstance, field: 'name', 'error')} required">
				<label for="name" class="col-sm-3 control-label"><g:message code="workCenter.name.label" default="Name" /><span class="required-indicator">*</span></label>
				<div class="col-sm-9">
					<g:textField name="name" class="form-control" required="" value="${workCenterInstance?.name}"/>
					<span class="help-inline">${hasErrors(bean: workCenterInstance, field: 'name', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: workCenterInstance, field: 'updatedBy', 'error')} ">
				<label for="updatedBy" class="col-sm-3 control-label"><g:message code="workCenter.updatedBy.label" default="Updated By" /></label>
				<div class="col-sm-9">
					<g:textField name="updatedBy" class="form-control" value="${workCenterInstance?.updatedBy}"/>
					<span class="help-inline">${hasErrors(bean: workCenterInstance, field: 'updatedBy', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: workCenterInstance, field: 'createdBy', 'error')} ">
				<label for="createdBy" class="col-sm-3 control-label"><g:message code="workCenter.createdBy.label" default="Created By" /></label>
				<div class="col-sm-9">
					<g:textField name="createdBy" class="form-control" value="${workCenterInstance?.createdBy}"/>
					<span class="help-inline">${hasErrors(bean: workCenterInstance, field: 'createdBy', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: workCenterInstance, field: 'line', 'error')} required">
				<label for="line" class="col-sm-3 control-label"><g:message code="workCenter.line.label" default="Line" /><span class="required-indicator">*</span></label>
				<div class="col-sm-9">
					<g:select id="line" name="line.id" from="${com.smanggin.trackingmanagement.Line.list()}" optionKey="id" required="" value="${workCenterInstance?.line?.id}" class="many-to-one form-control chosen-select"/>
					<span class="help-inline">${hasErrors(bean: workCenterInstance, field: 'line', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: workCenterInstance, field: 'plant', 'error')} required">
				<label for="plant" class="col-sm-3 control-label"><g:message code="workCenter.plant.label" default="Plant" /><span class="required-indicator">*</span></label>
				<div class="col-sm-9">
					<g:select id="plant" name="plant.id" from="${com.smanggin.trackingmanagement.Plant.list()}" optionKey="id" required="" value="${workCenterInstance?.plant?.id}" class="many-to-one form-control chosen-select"/>
					<span class="help-inline">${hasErrors(bean: workCenterInstance, field: 'plant', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: workCenterInstance, field: 'process', 'error')} required">
				<label for="process" class="col-sm-3 control-label"><g:message code="workCenter.process.label" default="Process" /><span class="required-indicator">*</span></label>
				<div class="col-sm-9">
					<g:select id="process" name="process.id" from="${com.smanggin.trackingmanagement.Process.list()}" optionKey="id" required="" value="${workCenterInstance?.process?.id}" class="many-to-one form-control chosen-select"/>
					<span class="help-inline">${hasErrors(bean: workCenterInstance, field: 'process', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: workCenterInstance, field: 'qCHeaders', 'error')} ">
				<label for="qCHeaders" class="col-sm-3 control-label"><g:message code="workCenter.qCHeaders.label" default="QCH eaders" /></label>
				<div class="col-sm-9">
					
<ul class="one-to-many">
<g:each in="${workCenterInstance?.qCHeaders?}" var="q">
    <li><g:link controller="QCHeader" action="show" id="${q.id}">${q?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="QCHeader" action="create" params="['workCenter.id': workCenterInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'QCHeader.label', default: 'QCHeader')])}</g:link>
</li>
</ul>

					<span class="help-inline">${hasErrors(bean: workCenterInstance, field: 'qCHeaders', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: workCenterInstance, field: 'sequenceNo', 'error')} required">
				<label for="sequenceNo" class="col-sm-3 control-label"><g:message code="workCenter.sequenceNo.label" default="Sequence No" /><span class="required-indicator">*</span></label>
				<div class="col-sm-9">
					<g:field type="number" name="sequenceNo" required="" value="${workCenterInstance.sequenceNo}"/>
					<span class="help-inline">${hasErrors(bean: workCenterInstance, field: 'sequenceNo', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: workCenterInstance, field: 'serverId', 'error')} ">
				<label for="serverId" class="col-sm-3 control-label"><g:message code="workCenter.serverId.label" default="Server Id" /></label>
				<div class="col-sm-9">
					<g:textField name="serverId" class="form-control" value="${workCenterInstance?.serverId}"/>
					<span class="help-inline">${hasErrors(bean: workCenterInstance, field: 'serverId', 'error')}</span>
				</div>
			</div>



