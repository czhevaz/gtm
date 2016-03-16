
<%@ page import="com.smanggin.trackingmanagement.Plant" %>
<!doctype html>
<html>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'plant.label', default: 'Plant')}" />
	<title><g:message code="default.show.label" args="[entityName]" /></title>
</head>

<body>

<section id="show-plant" class="first">
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
								<td valign="top" class="name"><g:message code="plant.code.label" default="Code" /></td>
								
								<td valign="top" class="value">${fieldValue(bean: plantInstance, field: "code")}</td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="plant.name.label" default="Name" /></td>
								
								<td valign="top" class="value">${fieldValue(bean: plantInstance, field: "name")}</td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="plant.address.label" default="Address" /></td>
								
								<td valign="top" class="value">${fieldValue(bean: plantInstance, field: "address")}</td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="plant.city.label" default="City" /></td>
								
								<td valign="top" class="value">${fieldValue(bean: plantInstance, field: "city")}</td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="plant.postalCode.label" default="Postal Code" /></td>
								
								<td valign="top" class="value">${fieldValue(bean: plantInstance, field: "postalCode")}</td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="plant.country.label" default="Country" /></td>
								
								<td valign="top" class="value">${fieldValue(bean: plantInstance, field: "country")}</td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="plant.phone1.label" default="Phone1" /></td>
								
								<td valign="top" class="value">${fieldValue(bean: plantInstance, field: "phone1")}</td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="plant.phone2.label" default="Phone2" /></td>
								
								<td valign="top" class="value">${fieldValue(bean: plantInstance, field: "phone2")}</td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="plant.email.label" default="Email" /></td>
								
								<td valign="top" class="value">${fieldValue(bean: plantInstance, field: "email")}</td>
								
							</tr>
						
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="plant.createdBy.label" default="Created By" /></td>
								
								<td valign="top" class="value">${fieldValue(bean: plantInstance, field: "createdBy")}</td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="plant.dateCreated.label" default="Date Created" /></td>
								
								<td valign="top" class="value"><g:formatDate date="${plantInstance?.dateCreated}" /></td>
								
							</tr>
							
							<tr class="prop">
								<td valign="top" class="name"><g:message code="plant.updatedBy.label" default="Updated By" /></td>
								
								<td valign="top" class="value">${fieldValue(bean: plantInstance, field: "updatedBy")}</td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="plant.lastUpdated.label" default="Last Updated" /></td>
								
								<td valign="top" class="value"><g:formatDate date="${plantInstance?.lastUpdated}" /></td>
								
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
