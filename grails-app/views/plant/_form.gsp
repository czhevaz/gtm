<%@ page import="com.smanggin.trackingmanagement.Plant" %>



			<div class="form-group fieldcontain ${hasErrors(bean: plantInstance, field: 'code', 'error')} required">
				<label for="code" class="col-sm-3 control-label"><g:message code="plant.code.label" default="Code" /><span class="required-indicator">*</span></label>
				<div class="col-sm-9">
					<g:textField name="code" class="form-control" required="" value="${plantInstance?.code}"/>
					<span class="help-inline">${hasErrors(bean: plantInstance, field: 'code', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: plantInstance, field: 'name', 'error')} required">
				<label for="name" class="col-sm-3 control-label"><g:message code="plant.name.label" default="Name" /><span class="required-indicator">*</span></label>
				<div class="col-sm-9">
					<g:textField name="name" class="form-control" required="" value="${plantInstance?.name}"/>
					<span class="help-inline">${hasErrors(bean: plantInstance, field: 'name', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: plantInstance, field: 'address', 'error')} ">
				<label for="address" class="col-sm-3 control-label"><g:message code="plant.address.label" default="Address" /></label>
				<div class="col-sm-9">
					<g:textField name="address" class="form-control" value="${plantInstance?.address}"/>
					<span class="help-inline">${hasErrors(bean: plantInstance, field: 'address', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: plantInstance, field: 'city', 'error')} ">
				<label for="city" class="col-sm-3 control-label"><g:message code="plant.city.label" default="City" /></label>
				<div class="col-sm-9">
					<g:textField name="city" class="form-control" value="${plantInstance?.city}"/>
					<span class="help-inline">${hasErrors(bean: plantInstance, field: 'city', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: plantInstance, field: 'postalCode', 'error')} ">
				<label for="postalCode" class="col-sm-3 control-label"><g:message code="plant.postalCode.label" default="Postal Code" /></label>
				<div class="col-sm-9">
					<g:textField name="postalCode" class="form-control" value="${plantInstance?.postalCode}"/>
					<span class="help-inline">${hasErrors(bean: plantInstance, field: 'postalCode', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: plantInstance, field: 'country', 'error')} ">
				<label for="country" class="col-sm-3 control-label"><g:message code="plant.country.label" default="Country" /></label>
				<div class="col-sm-9">
					<g:textField name="country" class="form-control" value="${plantInstance?.country}"/>
					<span class="help-inline">${hasErrors(bean: plantInstance, field: 'country', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: plantInstance, field: 'phone1', 'error')} ">
				<label for="phone1" class="col-sm-3 control-label"><g:message code="plant.phone1.label" default="Phone1" /></label>
				<div class="col-sm-9">
					<g:textField name="phone1" class="form-control" value="${plantInstance?.phone1}"/>
					<span class="help-inline">${hasErrors(bean: plantInstance, field: 'phone1', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: plantInstance, field: 'phone2', 'error')} ">
				<label for="phone2" class="col-sm-3 control-label"><g:message code="plant.phone2.label" default="Phone2" /></label>
				<div class="col-sm-9">
					<g:textField name="phone2" class="form-control" value="${plantInstance?.phone2}"/>
					<span class="help-inline">${hasErrors(bean: plantInstance, field: 'phone2', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: plantInstance, field: 'email', 'error')} ">
				<label for="email" class="col-sm-3 control-label"><g:message code="plant.email.label" default="Email" /></label>
				<div class="col-sm-9">
					<g:field type="email" name="email" class="form-control" value="${plantInstance?.email}"/>
					<span class="help-inline">${hasErrors(bean: plantInstance, field: 'email', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: plantInstance, field: 'updatedBy', 'error')} ">
				<label for="updatedBy" class="col-sm-3 control-label"><g:message code="plant.updatedBy.label" default="Updated By" /></label>
				<div class="col-sm-9">
					<g:textField name="updatedBy" class="form-control" value="${plantInstance?.updatedBy}"/>
					<span class="help-inline">${hasErrors(bean: plantInstance, field: 'updatedBy', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: plantInstance, field: 'createdBy', 'error')} ">
				<label for="createdBy" class="col-sm-3 control-label"><g:message code="plant.createdBy.label" default="Created By" /></label>
				<div class="col-sm-9">
					<g:textField name="createdBy" class="form-control" value="${plantInstance?.createdBy}"/>
					<span class="help-inline">${hasErrors(bean: plantInstance, field: 'createdBy', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: plantInstance, field: 'lineBalances', 'error')} ">
				<label for="lineBalances" class="col-sm-3 control-label"><g:message code="plant.lineBalances.label" default="Line Balances" /></label>
				<div class="col-sm-9">
					
<ul class="one-to-many">
<g:each in="${plantInstance?.lineBalances?}" var="l">
    <li><g:link controller="lineBalance" action="show" id="${l.id}">${l?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="lineBalance" action="create" params="['plant.id': plantInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'lineBalance.label', default: 'LineBalance')])}</g:link>
</li>
</ul>

					<span class="help-inline">${hasErrors(bean: plantInstance, field: 'lineBalances', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: plantInstance, field: 'productionInHeaders', 'error')} ">
				<label for="productionInHeaders" class="col-sm-3 control-label"><g:message code="plant.productionInHeaders.label" default="Production In Headers" /></label>
				<div class="col-sm-9">
					
<ul class="one-to-many">
<g:each in="${plantInstance?.productionInHeaders?}" var="p">
    <li><g:link controller="productionInHeader" action="show" id="${p.id}">${p?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="productionInHeader" action="create" params="['plant.id': plantInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'productionInHeader.label', default: 'ProductionInHeader')])}</g:link>
</li>
</ul>

					<span class="help-inline">${hasErrors(bean: plantInstance, field: 'productionInHeaders', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: plantInstance, field: 'qCHeaders', 'error')} ">
				<label for="qCHeaders" class="col-sm-3 control-label"><g:message code="plant.qCHeaders.label" default="QCH eaders" /></label>
				<div class="col-sm-9">
					
<ul class="one-to-many">
<g:each in="${plantInstance?.qCHeaders?}" var="q">
    <li><g:link controller="QCHeader" action="show" id="${q.id}">${q?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="QCHeader" action="create" params="['plant.id': plantInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'QCHeader.label', default: 'QCHeader')])}</g:link>
</li>
</ul>

					<span class="help-inline">${hasErrors(bean: plantInstance, field: 'qCHeaders', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: plantInstance, field: 'serverId', 'error')} ">
				<label for="serverId" class="col-sm-3 control-label"><g:message code="plant.serverId.label" default="Server Id" /></label>
				<div class="col-sm-9">
					<g:textField name="serverId" class="form-control" value="${plantInstance?.serverId}"/>
					<span class="help-inline">${hasErrors(bean: plantInstance, field: 'serverId', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: plantInstance, field: 'userPlants', 'error')} ">
				<label for="userPlants" class="col-sm-3 control-label"><g:message code="plant.userPlants.label" default="User Plants" /></label>
				<div class="col-sm-9">
					
<ul class="one-to-many">
<g:each in="${plantInstance?.userPlants?}" var="u">
    <li><g:link controller="userPlants" action="show" id="${u.id}">${u?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="userPlants" action="create" params="['plant.id': plantInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'userPlants.label', default: 'UserPlants')])}</g:link>
</li>
</ul>

					<span class="help-inline">${hasErrors(bean: plantInstance, field: 'userPlants', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: plantInstance, field: 'workCenters', 'error')} ">
				<label for="workCenters" class="col-sm-3 control-label"><g:message code="plant.workCenters.label" default="Work Centers" /></label>
				<div class="col-sm-9">
					
<ul class="one-to-many">
<g:each in="${plantInstance?.workCenters?}" var="w">
    <li><g:link controller="workCenter" action="show" id="${w.id}">${w?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="workCenter" action="create" params="['plant.id': plantInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'workCenter.label', default: 'WorkCenter')])}</g:link>
</li>
</ul>

					<span class="help-inline">${hasErrors(bean: plantInstance, field: 'workCenters', 'error')}</span>
				</div>
			</div>



