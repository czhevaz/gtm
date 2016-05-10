
<%@ page import="com.smanggin.trackingmanagement.WorkCenter" %>
<!doctype html>
<html>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'workCenter.label', default: 'WorkCenter')}" />
	<title><g:message code="default.show.label" args="[entityName]" /></title>
</head>

<body>

<section id="show-workCenter" class="first">
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
								<td valign="top" class="name"><g:message code="workCenter.name.label" default="Name" /></td>
								
								<td valign="top" class="value">${fieldValue(bean: workCenterInstance, field: "name")}</td>
								
							</tr>
						
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="workCenter.line.label" default="Line" /></td>
								
								<td valign="top" class="value"><g:link controller="line" action="show" id="${workCenterInstance?.line?.id}">${workCenterInstance?.line?.encodeAsHTML()}</g:link></td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="workCenter.plant.label" default="Plant" /></td>
								
								<td valign="top" class="value"><g:link controller="plant" action="show" id="${workCenterInstance?.plant?.id}">${workCenterInstance?.plant?.encodeAsHTML()}</g:link></td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="workCenter.process.label" default="Process" /></td>
								
								<td valign="top" class="value"><g:link controller="process" action="show" id="${workCenterInstance?.process?.id}">${workCenterInstance?.process?.encodeAsHTML()}</g:link></td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="workCenter.sequenceNo.label" default="Sequence No" /></td>
								
								<td valign="top" class="value">${fieldValue(bean: workCenterInstance, field: "sequenceNo")}</td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="workCenter.createdBy.label" default="Created By" /></td>
								
								<td valign="top" class="value">${fieldValue(bean: workCenterInstance, field: "createdBy")}</td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="workCenter.dateCreated.label" default="Date Created" /></td>
								
								<td valign="top" class="value"><g:formatDate date="${workCenterInstance?.dateCreated}" /></td>
								
							</tr>

							<tr class="prop">
								<td valign="top" class="name"><g:message code="workCenter.updatedBy.label" default="Updated By" /></td>
								
								<td valign="top" class="value">${fieldValue(bean: workCenterInstance, field: "updatedBy")}</td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="workCenter.lastUpdated.label" default="Last Updated" /></td>
								
								<td valign="top" class="value"><g:formatDate date="${workCenterInstance?.lastUpdated}" /></td>
								
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
