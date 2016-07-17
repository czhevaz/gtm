
<%@ page import="com.smanggin.trackingmanagement.ReceiveItem" %>
<!doctype html>
<html>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'receiveItem.label', default: 'ReceiveItem')}" />
	<title><g:message code="default.show.label" args="[entityName]" /></title>
</head>

<body>

<section id="show-receiveItem" class="first">
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
								<td valign="top" class="name"><g:message code="receiveItem.number.label" default="Number" /></td>
								
								<td valign="top" class="value">${receiveItemInstance?.number?.encodeAsHTML()}</td>
								
							</tr>

							<tr class="prop">
								<td valign="top" class="name"><g:message code="receiveItem.reffNo.label" default="reffNo" /></td>
								
								<td valign="top" class="value">${fieldValue(bean: receiveItemInstance, field: "reffNo")}</td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="receiveItem.transactionGroup.label" default="TransactionGroup" /></td>
								
								<td valign="top" class="value"><g:link controller="TransactionGroup" action="show" id="${receiveItemInstance?.transactionGroup?.serverId}">${receiveItemInstance?.transactionGroup?.encodeAsHTML()}</g:link></td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="receiveItem.supplier.label" default="Supplier" /></td>
								
								<td valign="top" class="value"><g:link controller="supplier" action="show" id="${receiveItemInstance?.supplier?.serverId}">${receiveItemInstance?.supplier?.encodeAsHTML()}</g:link></td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="receiveItem.shift.label" default="Shift" /></td>
								
								<td valign="top" class="value">${fieldValue(bean: receiveItemInstance, field: "shift")}</td>
								
							</tr>
							
							<tr class="prop">
								<td valign="top" class="name"><g:message code="receiveItem.groupShift.label" default="Group Shift" /></td>
								
								<td valign="top" class="value">${fieldValue(bean: receiveItemInstance, field: "groupShift")}</td>
								
							</tr>

							<tr class="prop">
								<td valign="top" class="name"><g:message code="receiveItem.productionDate.label" default="Production Date" /></td>
								
								<td valign="top" class="value"><g:formatDate date="${receiveItemInstance?.productionDate}" /></td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="receiveItem.productionLine.label" default="Production Line" /></td>
								
								<td valign="top" class="value">${fieldValue(bean: receiveItemInstance, field: "productionLine")}</td>
								
							</tr>
							
							<tr class="prop">
								<td valign="top" class="name"><g:message code="receiveItem.startNumber.label" default="Start Number" /></td>
								
								<td valign="top" class="value">${fieldValue(bean: receiveItemInstance, field: "startNumber")}</td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="receiveItem.endNumber.label" default="End Number" /></td>
								
								<td valign="top" class="value">${fieldValue(bean: receiveItemInstance, field: "endNumber")}</td>
								
							</tr>
							
							<tr class="prop">
								<td valign="top" class="name"><g:message code="receiveItem.remarks.label" default="remarks" /></td>
								
								<td valign="top" class="value">${fieldValue(bean: receiveItemInstance, field: "remarks")}</td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="receiveItem.updatedBy.label" default="Updated By" /></td>
								
								<td valign="top" class="value">${fieldValue(bean: receiveItemInstance, field: "updatedBy")}</td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="receiveItem.createdBy.label" default="Created By" /></td>
								
								<td valign="top" class="value">${fieldValue(bean: receiveItemInstance, field: "createdBy")}</td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="receiveItem.dateCreated.label" default="Date Created" /></td>
								
								<td valign="top" class="value"><g:formatDate date="${receiveItemInstance?.dateCreated}" /></td>
								
							</tr>
						
							
							<tr class="prop">
								<td valign="top" class="name"><g:message code="receiveItem.lastUpdated.label" default="Last Updated" /></td>
								
								<td valign="top" class="value"><g:formatDate date="${receiveItemInstance?.lastUpdated}" /></td>
								
							</tr>
						
							
						</tbody>
					</table>
				</div><!--/.row -->
				<div class="box-footer">
				<g:form method="post" class="form-horizontal" >
						<div class="form-actions">
								<g:actionSubmit class="btn btn-primary btn-sm" action="create" value="${message(code: 'default.button.save.label', default: 'Save')}" />
							
						</div>
				</g:form>		
				</div><!--/.box-footer -->	
			</div><!--/.box-body table-responsive -->

			<g:render template="detail"/> 
		</div><!--/.box box-primary -->
	</div><!--/.row -->
</section>

</body>

</html>
