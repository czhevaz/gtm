
<%@ page import="com.smanggin.trackingmanagement.Line" %>
<!doctype html>
<html>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'line.label', default: 'Line')}" />
	<title><g:message code="default.show.label" args="[entityName]" /></title>
</head>

<body>

<section id="show-line" class="first">
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
								<td valign="top" class="name"><g:message code="line.code.label" default="Code" /></td>
								
								<td valign="top" class="value">${fieldValue(bean: lineInstance, field: "code")}</td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="line.name.label" default="Name" /></td>
								
								<td valign="top" class="value">${fieldValue(bean: lineInstance, field: "name")}</td>
								
							</tr>
						
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="line.createdBy.label" default="Created By" /></td>
								
								<td valign="top" class="value">${fieldValue(bean: lineInstance, field: "createdBy")}</td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="line.dateCreated.label" default="Date Created" /></td>
								
								<td valign="top" class="value"><g:formatDate date="${lineInstance?.dateCreated}" /></td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="line.updatedBy.label" default="Updated By" /></td>
								
								<td valign="top" class="value">${fieldValue(bean: lineInstance, field: "updatedBy")}</td>
								
							</tr>


							<tr class="prop">
								<td valign="top" class="name"><g:message code="line.lastUpdated.label" default="Last Updated" /></td>
								
								<td valign="top" class="value"><g:formatDate date="${lineInstance?.lastUpdated}" /></td>
								
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
