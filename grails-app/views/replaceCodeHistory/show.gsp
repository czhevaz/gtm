
<%@ page import="com.smanggin.trackingmanagement.ReplaceCodeHistory" %>
<!doctype html>
<html>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'replaceCodeHistory.label', default: 'ReplaceCodeHistory')}" />
	<title><g:message code="default.show.label" args="[entityName]" /></title>
</head>

<body>

<section id="show-replaceCodeHistory" class="first">
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
								<td valign="top" class="name"><g:message code="replaceCodeHistory.gallon.label" default="Gallon" /></td>
								
								<td valign="top" class="value"><g:link controller="gallon" action="show" id="${replaceCodeHistoryInstance?.gallon?.id}">${replaceCodeHistoryInstance?.gallon?.encodeAsHTML()}</g:link></td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="replaceCodeHistory.createdBy.label" default="Created By" /></td>
								
								<td valign="top" class="value">${fieldValue(bean: replaceCodeHistoryInstance, field: "createdBy")}</td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="replaceCodeHistory.dateCreated.label" default="Date Created" /></td>
								
								<td valign="top" class="value"><g:formatDate date="${replaceCodeHistoryInstance?.dateCreated}" /></td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="replaceCodeHistory.lastUpdated.label" default="Last Updated" /></td>
								
								<td valign="top" class="value"><g:formatDate date="${replaceCodeHistoryInstance?.lastUpdated}" /></td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="replaceCodeHistory.newNumber.label" default="New Number" /></td>
								
								<td valign="top" class="value">${fieldValue(bean: replaceCodeHistoryInstance, field: "newNumber")}</td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="replaceCodeHistory.oldNumber.label" default="Old Number" /></td>
								
								<td valign="top" class="value">${fieldValue(bean: replaceCodeHistoryInstance, field: "oldNumber")}</td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="replaceCodeHistory.reason.label" default="Reason" /></td>
								
								<td valign="top" class="value">${fieldValue(bean: replaceCodeHistoryInstance, field: "reason")}</td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="replaceCodeHistory.serverId.label" default="Server Id" /></td>
								
								<td valign="top" class="value">${fieldValue(bean: replaceCodeHistoryInstance, field: "serverId")}</td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="replaceCodeHistory.updatedBy.label" default="Updated By" /></td>
								
								<td valign="top" class="value">${fieldValue(bean: replaceCodeHistoryInstance, field: "updatedBy")}</td>
								
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
