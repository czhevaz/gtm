
<%@ page import="com.smanggin.trackingmanagement.CloseShift" %>
<!doctype html>
<html>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'closeShift.label', default: 'CloseShift')}" />
	<title><g:message code="default.show.label" args="[entityName]" /></title>
</head>

<body>

<section id="show-closeShift" class="first">
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
								<td valign="top" class="name"><g:message code="closeShift.closeDate.label" default="Close Date" /></td>
								
								<td valign="top" class="value"><g:formatDate date="${closeShiftInstance?.closeDate}" /></td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="closeShift.dateCreated.label" default="Date Created" /></td>
								
								<td valign="top" class="value"><g:formatDate date="${closeShiftInstance?.dateCreated}" /></td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="closeShift.lastUpdated.label" default="Last Updated" /></td>
								
								<td valign="top" class="value"><g:formatDate date="${closeShiftInstance?.lastUpdated}" /></td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="closeShift.line.label" default="Line" /></td>
								
								<td valign="top" class="value"><g:link controller="line" action="show" id="${closeShiftInstance?.line?.id}">${closeShiftInstance?.line?.encodeAsHTML()}</g:link></td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="closeShift.serverId.label" default="Server Id" /></td>
								
								<td valign="top" class="value">${fieldValue(bean: closeShiftInstance, field: "serverId")}</td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="closeShift.shift.label" default="Shift" /></td>
								
								<td valign="top" class="value"><g:link controller="shift" action="show" id="${closeShiftInstance?.shift?.id}">${closeShiftInstance?.shift?.encodeAsHTML()}</g:link></td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="closeShift.yieldBySystem.label" default="Yield By System" /></td>
								
								<td valign="top" class="value">${fieldValue(bean: closeShiftInstance, field: "yieldBySystem")}</td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="closeShift.yieldByUser.label" default="Yield By User" /></td>
								
								<td valign="top" class="value">${fieldValue(bean: closeShiftInstance, field: "yieldByUser")}</td>
								
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
