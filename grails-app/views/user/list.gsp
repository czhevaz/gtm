
<%@ page import="com.smanggin.trackingmanagement.User" %>
<!doctype html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
	<title><g:message code="default.list.label" args="[entityName]" /></title>
</head>

<body>
	
<section id="list-user" class="first">
	<div class="row">
		<div class="col-lg-12">
			<div class="box box-primary">
				
				<div class="box-header with-border">
                  <h3 class="box-title"><g:message code="default.list.label" args="[entityName]" /></h3>
                </div><!--/.box-header with-border -->

				<div class="box-body table-responsive">	
					<table class="table table-bordered margin-top-medium">
						<thead>
							<tr>
							
								<g:sortableColumn property="login" title="${message(code: 'user.login.label', default: 'Login')}" />
							
								<g:sortableColumn property="email" title="${message(code: 'user.email.label', default: 'Email')}" />
							
								<g:sortableColumn property="mobileNo1" title="${message(code: 'user.mobileNo1.label', default: 'Mobile No1')}" />
							
								<g:sortableColumn property="mobileNo2" title="${message(code: 'user.mobileNo2.label', default: 'Mobile No2')}" />
							
								<g:sortableColumn property="updatedBy" title="${message(code: 'user.updatedBy.label', default: 'Updated By')}" />
							
							</tr>
						</thead>
						<tbody>
						<g:each in="${userInstanceList}" status="i" var="userInstance">
							<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
							
								<td><g:link action="show" params="[serverId:userInstance?.serverId]">${fieldValue(bean: userInstance, field: "login")}</g:link></td>

								<td>${fieldValue(bean: userInstance, field: "email")}</td>
							
								<td>${fieldValue(bean: userInstance, field: "mobileNo1")}</td>
							
								<td>${fieldValue(bean: userInstance, field: "mobileNo2")}</td>
							
								<td>${fieldValue(bean: userInstance, field: "updatedBy")}</td>
							
							</tr>
						</g:each>
						</tbody>
					</table>
				</div><!--/.box-body table-responsive -->

				<div class="box-footer clearfix">
					<bs:paginate total="${userInstanceTotal}" />
				</div><!--/.box-footer clearfix -->
			</div><!--/.box box-primary -->	
		</div><!--/.col-lg-12 -->	
	</div><!--/.row -->			

</section>

</body>

</html>
