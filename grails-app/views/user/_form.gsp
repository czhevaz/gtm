<%@ page import="com.smanggin.trackingmanagement.User" %>



			<div class="form-group fieldcontain ${hasErrors(bean: userInstance, field: 'login', 'error')} required">
				<label for="login" class="col-sm-3 control-label"><g:message code="user.login.label" default="Login" /><span class="required-indicator">*</span></label>
				<div class="col-sm-9">
					<g:textField name="login" class="form-control" required="" value="${userInstance?.login}"/>
					<span class="help-inline">${hasErrors(bean: userInstance, field: 'login', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: userInstance, field: 'password', 'error')} required">
				<label for="password" class="col-sm-3 control-label"><g:message code="user.password.label" default="Password" /><span class="required-indicator">*</span></label>
				<div class="col-sm-9">
					<g:passwordField name="password" class="form-control" maxlength="15" required="" value="${userInstance?.password}"/>
					<span class="help-inline">${hasErrors(bean: userInstance, field: 'password', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: userInstance, field: 'email', 'error')} required">
				<label for="email" class="col-sm-3 control-label"><g:message code="user.email.label" default="Email" /><span class="required-indicator">*</span></label>
				<div class="col-sm-9">
					<g:field type="email" name="email" class="form-control" required="" value="${userInstance?.email}"/>
					<span class="help-inline">${hasErrors(bean: userInstance, field: 'email', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: userInstance, field: 'mobileNo1', 'error')} ">
				<label for="mobileNo1" class="col-sm-3 control-label"><g:message code="user.mobileNo1.label" default="Mobile No1" /></label>
				<div class="col-sm-9">
					<g:textField name="mobileNo1" class="form-control" value="${userInstance?.mobileNo1}"/>
					<span class="help-inline">${hasErrors(bean: userInstance, field: 'mobileNo1', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: userInstance, field: 'mobileNo2', 'error')} ">
				<label for="mobileNo2" class="col-sm-3 control-label"><g:message code="user.mobileNo2.label" default="Mobile No2" /></label>
				<div class="col-sm-9">
					<g:textField name="mobileNo2" class="form-control" value="${userInstance?.mobileNo2}"/>
					<span class="help-inline">${hasErrors(bean: userInstance, field: 'mobileNo2', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: userInstance, field: 'updatedBy', 'error')} ">
				<label for="updatedBy" class="col-sm-3 control-label"><g:message code="user.updatedBy.label" default="Updated By" /></label>
				<div class="col-sm-9">
					<g:textField name="updatedBy" class="form-control" value="${userInstance?.updatedBy}" readonly="true" />
					<span class="help-inline">${hasErrors(bean: userInstance, field: 'updatedBy', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: userInstance, field: 'createdBy', 'error')} ">
				<label for="createdBy" class="col-sm-3 control-label"><g:message code="user.createdBy.label" default="Created By" /></label>
				<div class="col-sm-9">
					<g:textField name="createdBy" class="form-control" value="${userInstance?.createdBy}" readonly="true" />
					<span class="help-inline">${hasErrors(bean: userInstance, field: 'createdBy', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: userInstance, field: 'serverId', 'error')} ">
				<label for="serverId" class="col-sm-3 control-label"><g:message code="user.serverId.label" default="Server Id" /></label>
				<div class="col-sm-9">
					<g:textField name="serverId" class="form-control" value="${userInstance?.serverId}" readonly="true" />
					<span class="help-inline">${hasErrors(bean: userInstance, field: 'serverId', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: userInstance, field: 'status', 'error')} required">
				<label for="status" class="col-sm-3 control-label"><g:message code="user.status.label" default="Status" /><span class="required-indicator">*</span></label>
				<div class="col-sm-9">
					<g:field type="number" name="status" required="" value="${userInstance.status}"/>
					<span class="help-inline">${hasErrors(bean: userInstance, field: 'status', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: userInstance, field: 'userPlants', 'error')} ">
				<label for="userPlants" class="col-sm-3 control-label"><g:message code="user.userPlants.label" default="User Plants" /></label>
				<div class="col-sm-9">
					
<ul class="one-to-many">
<g:each in="${userInstance?.userPlants?}" var="u">
    <li><g:link controller="userPlants" action="show" id="${u.id}">${u?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="userPlants" action="create" params="['user.id': userInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'userPlants.label', default: 'UserPlants')])}</g:link>
</li>
</ul>

					<span class="help-inline">${hasErrors(bean: userInstance, field: 'userPlants', 'error')}</span>
				</div>
			</div>



