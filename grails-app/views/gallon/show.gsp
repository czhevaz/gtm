
<%@ page import="com.smanggin.trackingmanagement.Gallon" %>
<!doctype html>
<html>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'gallon.label', default: 'Gallon')}" />
	<title><g:message code="default.show.label" args="[entityName]" /></title>
</head>

<body>

<section id="show-gallon" class="first">
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
								<td valign="top" class="name"><g:message code="gallon.code.label" default="Code" /></td>
								
								<td valign="top" class="value">${fieldValue(bean: gallonInstance, field: "code")}</td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="gallon.writeOff.label" default="Write Off" /></td>
								
								<td valign="top" class="value"><g:formatBoolean boolean="${gallonInstance?.writeOff}" /></td>
								
							</tr>
						
							
							<tr class="prop">
								<td valign="top" class="name"><g:message code="gallon.createdBy.label" default="Created By" /></td>
								
								<td valign="top" class="value">${fieldValue(bean: gallonInstance, field: "createdBy")}</td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="gallon.dateCreated.label" default="Date Created" /></td>
								
								<td valign="top" class="value"><g:formatDate date="${gallonInstance?.dateCreated}" /></td>
								
							</tr>
							
							<tr class="prop">
								<td valign="top" class="name"><g:message code="gallon.updatedBy.label" default="Updated By" /></td>
								
								<td valign="top" class="value">${fieldValue(bean: gallonInstance, field: "updatedBy")}</td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="gallon.lastUpdated.label" default="Last Updated" /></td>
								
								<td valign="top" class="value"><g:formatDate date="${gallonInstance?.lastUpdated}" /></td>
								
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
