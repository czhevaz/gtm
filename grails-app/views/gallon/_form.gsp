<%@ page import="com.smanggin.trackingmanagement.Gallon" %>



			<div class="form-group fieldcontain ${hasErrors(bean: gallonInstance, field: 'code', 'error')} required">
				<label for="code" class="col-sm-3 control-label"><g:message code="gallon.code.label" default="Code" /><span class="required-indicator">*</span></label>
				<div class="col-sm-9">
					<g:textField name="code" class="form-control" required="" value="${gallonInstance?.code}"/>
					<span class="help-inline">${hasErrors(bean: gallonInstance, field: 'code', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: gallonInstance, field: 'writeOff', 'error')} ">
				<label for="writeOff" class="col-sm-3 control-label"><g:message code="gallon.writeOff.label" default="Write Off" /></label>
				<div class="col-sm-9">
					<bs:checkBox name="writeOff" value="${gallonInstance?.writeOff}" />
					<span class="help-inline">${hasErrors(bean: gallonInstance, field: 'writeOff', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: gallonInstance, field: 'updatedBy', 'error')} ">
				<label for="updatedBy" class="col-sm-3 control-label"><g:message code="gallon.updatedBy.label" default="Updated By" /></label>
				<div class="col-sm-9">
					<g:textField name="updatedBy" class="form-control" value="${gallonInstance?.updatedBy}"/>
					<span class="help-inline">${hasErrors(bean: gallonInstance, field: 'updatedBy', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: gallonInstance, field: 'createdBy', 'error')} ">
				<label for="createdBy" class="col-sm-3 control-label"><g:message code="gallon.createdBy.label" default="Created By" /></label>
				<div class="col-sm-9">
					<g:textField name="createdBy" class="form-control" value="${gallonInstance?.createdBy}"/>
					<span class="help-inline">${hasErrors(bean: gallonInstance, field: 'createdBy', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: gallonInstance, field: 'productionInDetails', 'error')} ">
				<label for="productionInDetails" class="col-sm-3 control-label"><g:message code="gallon.productionInDetails.label" default="Production In Details" /></label>
				<div class="col-sm-9">
					
<ul class="one-to-many">
<g:each in="${gallonInstance?.productionInDetails?}" var="p">
    <li><g:link controller="productionInDetail" action="show" id="${p.id}">${p?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="productionInDetail" action="create" params="['gallon.id': gallonInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'productionInDetail.label', default: 'ProductionInDetail')])}</g:link>
</li>
</ul>

					<span class="help-inline">${hasErrors(bean: gallonInstance, field: 'productionInDetails', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: gallonInstance, field: 'qCHeaders', 'error')} ">
				<label for="qCHeaders" class="col-sm-3 control-label"><g:message code="gallon.qCHeaders.label" default="QCH eaders" /></label>
				<div class="col-sm-9">
					
<ul class="one-to-many">
<g:each in="${gallonInstance?.qCHeaders?}" var="q">
    <li><g:link controller="QCHeader" action="show" id="${q.id}">${q?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="QCHeader" action="create" params="['gallon.id': gallonInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'QCHeader.label', default: 'QCHeader')])}</g:link>
</li>
</ul>

					<span class="help-inline">${hasErrors(bean: gallonInstance, field: 'qCHeaders', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: gallonInstance, field: 'serverId', 'error')} ">
				<label for="serverId" class="col-sm-3 control-label"><g:message code="gallon.serverId.label" default="Server Id" /></label>
				<div class="col-sm-9">
					<g:textField name="serverId" class="form-control" value="${gallonInstance?.serverId}"/>
					<span class="help-inline">${hasErrors(bean: gallonInstance, field: 'serverId', 'error')}</span>
				</div>
			</div>



