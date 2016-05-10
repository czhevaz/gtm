
<%@ page import="com.smanggin.trackingmanagement.QCMaster" %>
<!doctype html>
<html>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'QCMaster.label', default: 'QCMaster')}" />
	<title><g:message code="default.show.label" args="[entityName]" /></title>
</head>

<body>

<section id="show-QCMaster" class="first">
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
								<td valign="top" class="name"><g:message code="QCMaster.code.label" default="Code" /></td>
								
								<td valign="top" class="value">${fieldValue(bean: QCMasterInstance, field: "code")}</td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="QCMaster.name.label" default="Name" /></td>
								
								<td valign="top" class="value">${fieldValue(bean: QCMasterInstance, field: "name")}</td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="QCMaster.user.label" default="User" /></td>
								
								<td valign="top" class="value"><g:link controller="user" action="show" id="${QCMasterInstance?.user?.id}">${QCMasterInstance?.user?.encodeAsHTML()}</g:link></td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="QCMaster.active.label" default="Active" /></td>
								
								<td valign="top" class="value"><g:formatBoolean boolean="${QCMasterInstance?.active}" /></td>
								
							</tr>

							<tr class="prop">
								<td valign="top" class="name"><g:message code="QCMaster.dateInActive.label" default="Date In Active" /></td>
								
								<td valign="top" class="value"><g:formatDate date="${QCMasterInstance?.dateInActive}" /></td>
								
							</tr>

							<tr class="prop">
								<td valign="top" class="name"><g:message code="QCMaster.updatedBy.label" default="Updated By" /></td>
								
								<td valign="top" class="value">${fieldValue(bean: QCMasterInstance, field: "updatedBy")}</td>
								
							</tr>
						

						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="QCMaster.createdBy.label" default="Created By" /></td>
								
								<td valign="top" class="value">${fieldValue(bean: QCMasterInstance, field: "createdBy")}</td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="QCMaster.dateCreated.label" default="Date Created" /></td>
								
								<td valign="top" class="value"><g:formatDate date="${QCMasterInstance?.dateCreated}" /></td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="QCMaster.lastUpdated.label" default="Last Updated" /></td>
								
								<td valign="top" class="value"><g:formatDate date="${QCMasterInstance?.lastUpdated}" /></td>
								
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
