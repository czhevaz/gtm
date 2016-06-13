
<%@ page import="com.smanggin.trackingmanagement.Supplier" %>
<!doctype html>
<html>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'supplier.label', default: 'Supplier')}" />
	<title><g:message code="default.show.label" args="[entityName]" /></title>
</head>

<body>

<section id="show-supplier" class="first">
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
								<td valign="top" class="name"><g:message code="supplier.code.label" default="Code" /></td>
								
								<td valign="top" class="value">${fieldValue(bean: supplierInstance, field: "code")}</td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="supplier.postCode.label" default="Post Code" /></td>
								
								<td valign="top" class="value">${fieldValue(bean: supplierInstance, field: "postCode")}</td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="supplier.phones.label" default="Phones" /></td>
								
								<td valign="top" class="value">${fieldValue(bean: supplierInstance, field: "phones")}</td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="supplier.telex.label" default="Telex" /></td>
								
								<td valign="top" class="value">${fieldValue(bean: supplierInstance, field: "telex")}</td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="supplier.fax.label" default="Fax" /></td>
								
								<td valign="top" class="value">${fieldValue(bean: supplierInstance, field: "fax")}</td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="supplier.email.label" default="Email" /></td>
								
								<td valign="top" class="value">${fieldValue(bean: supplierInstance, field: "email")}</td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="supplier.city.label" default="City" /></td>
								
								<td valign="top" class="value">${fieldValue(bean: supplierInstance, field: "city")}</td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="supplier.state.label" default="State" /></td>
								
								<td valign="top" class="value">${fieldValue(bean: supplierInstance, field: "state")}</td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="supplier.contactPerson.label" default="Contact Person" /></td>
								
								<td valign="top" class="value">${fieldValue(bean: supplierInstance, field: "contactPerson")}</td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="supplier.mobileNo.label" default="Mobile No" /></td>
								
								<td valign="top" class="value">${fieldValue(bean: supplierInstance, field: "mobileNo")}</td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="supplier.createdBy.label" default="Created By" /></td>
								
								<td valign="top" class="value">${fieldValue(bean: supplierInstance, field: "createdBy")}</td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="supplier.address.label" default="Address" /></td>
								
								<td valign="top" class="value">${fieldValue(bean: supplierInstance, field: "address")}</td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="supplier.dateCreated.label" default="Date Created" /></td>
								
								<td valign="top" class="value"><g:formatDate date="${supplierInstance?.dateCreated}" /></td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="supplier.lastUpdated.label" default="Last Updated" /></td>
								
								<td valign="top" class="value"><g:formatDate date="${supplierInstance?.lastUpdated}" /></td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="supplier.name.label" default="Name" /></td>
								
								<td valign="top" class="value">${fieldValue(bean: supplierInstance, field: "name")}</td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="supplier.serverId.label" default="Server Id" /></td>
								
								<td valign="top" class="value">${fieldValue(bean: supplierInstance, field: "serverId")}</td>
								
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
