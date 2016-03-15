
<%@ page import="com.smanggin.trackingmanagement.ProductionInHeader" %>
<!doctype html>
<html>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'productionInHeader.label', default: 'ProductionInHeader')}" />
	<title><g:message code="default.show.label" args="[entityName]" /></title>
</head>

<body>

<section id="show-productionInHeader" class="first">
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
								<td valign="top" class="name"><g:message code="productionInHeader.updatedBy.label" default="Updated By" /></td>
								
								<td valign="top" class="value">${fieldValue(bean: productionInHeaderInstance, field: "updatedBy")}</td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="productionInHeader.createdBy.label" default="Created By" /></td>
								
								<td valign="top" class="value">${fieldValue(bean: productionInHeaderInstance, field: "createdBy")}</td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="productionInHeader.date.label" default="Date" /></td>
								
								<td valign="top" class="value"><g:formatDate date="${productionInHeaderInstance?.date}" /></td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="productionInHeader.dateCreated.label" default="Date Created" /></td>
								
								<td valign="top" class="value"><g:formatDate date="${productionInHeaderInstance?.dateCreated}" /></td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="productionInHeader.lastUpdated.label" default="Last Updated" /></td>
								
								<td valign="top" class="value"><g:formatDate date="${productionInHeaderInstance?.lastUpdated}" /></td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="productionInHeader.number.label" default="Number" /></td>
								
								<td valign="top" class="value">${fieldValue(bean: productionInHeaderInstance, field: "number")}</td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="productionInHeader.plant.label" default="Plant" /></td>
								
								<td valign="top" class="value"><g:link controller="plant" action="show" id="${productionInHeaderInstance?.plant?.id}">${productionInHeaderInstance?.plant?.encodeAsHTML()}</g:link></td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="productionInHeader.productionInDetails.label" default="Production In Details" /></td>
								
								<td valign="top" style="text-align: left;" class="value">
									<ul>
									<g:each in="${productionInHeaderInstance.productionInDetails}" var="p">
										<li><g:link controller="productionInDetail" action="show" id="${p.id}">${p?.encodeAsHTML()}</g:link></li>
									</g:each>
									</ul>
								</td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="productionInHeader.serverId.label" default="Server Id" /></td>
								
								<td valign="top" class="value">${fieldValue(bean: productionInHeaderInstance, field: "serverId")}</td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="productionInHeader.totalGallon.label" default="Total Gallon" /></td>
								
								<td valign="top" class="value">${fieldValue(bean: productionInHeaderInstance, field: "totalGallon")}</td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="productionInHeader.transactionGroup.label" default="Transaction Group" /></td>
								
								<td valign="top" class="value"><g:link controller="transactionGroup" action="show" id="${productionInHeaderInstance?.transactionGroup?.id}">${productionInHeaderInstance?.transactionGroup?.encodeAsHTML()}</g:link></td>
								
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
