
<%@ page import="com.smanggin.trackingmanagement.User" %>
<!doctype html>
<html>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
	<title><g:message code="default.show.label" args="[entityName]" /></title>
</head>

<body>

<section id="show-user" class="first">
	<div class="row">
		<div class="col-lg-12">
			<div class="box box-primary">
				<div class="box-header with-border">
                  <h3 class="box-title"><g:message code="default.show.label" args="[entityName]" /></h3>
                </div><!--/.box-header with-border -->	
                <div class="box-body table-responsive">
					<table class="table table-striped">
						<tbody>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="user.login.label" default="Login" /></td>
								
								<td valign="top" class="value">${fieldValue(bean: userInstance, field: "login")}</td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="user.password.label" default="Password" /></td>
								
								<td valign="top" class="value">${fieldValue(bean: userInstance, field: "password")}</td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="user.email.label" default="Email" /></td>
								
								<td valign="top" class="value">${fieldValue(bean: userInstance, field: "email")}</td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="user.mobileNo1.label" default="Mobile No1" /></td>
								
								<td valign="top" class="value">${fieldValue(bean: userInstance, field: "mobileNo1")}</td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="user.mobileNo2.label" default="Mobile No2" /></td>
								
								<td valign="top" class="value">${fieldValue(bean: userInstance, field: "mobileNo2")}</td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="user.updatedBy.label" default="Updated By" /></td>
								
								<td valign="top" class="value">${fieldValue(bean: userInstance, field: "updatedBy")}</td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="user.createdBy.label" default="Created By" /></td>
								
								<td valign="top" class="value">${fieldValue(bean: userInstance, field: "createdBy")}</td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="user.dateCreated.label" default="Date Created" /></td>
								
								<td valign="top" class="value"><g:formatDate date="${userInstance?.dateCreated}" /></td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="user.lastUpdated.label" default="Last Updated" /></td>
								
								<td valign="top" class="value"><g:formatDate date="${userInstance?.lastUpdated}" /></td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="user.serverId.label" default="Server Id" /></td>
								
								<td valign="top" class="value">${fieldValue(bean: userInstance, field: "serverId")}</td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="user.status.label" default="Status" /></td>
								
								<td valign="top" class="value">${fieldValue(bean: userInstance, field: "status")}</td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="user.userPlants.label" default="User Plants" /></td>
								
								<td valign="top" style="text-align: left;" class="value">
									<ul>
									<g:each in="${userInstance.userPlants}" var="u">
										<li><g:link controller="userPlants" action="show" id="${u.id}">${u?.encodeAsHTML()}</g:link></li>
									</g:each>
									</ul>
								</td>
								
							</tr>
						
						</tbody>
					</table>
				</div><!--/.row -->
				<div class="box-footer clearfix">
						
				</div><!--/.box-footer clearfix -->
			</div><!--/.box-body table-responsive -->

			<g:render template="detail"/> 
		</div><!--/.box box-primary -->
	</div><!--/.row -->
</section>

</body>

</html>
