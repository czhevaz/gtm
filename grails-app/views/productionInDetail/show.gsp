
<%@ page import="com.smanggin.trackingmanagement.ProductionInDetail" %>
<!doctype html>
<html>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'productionInDetail.label', default: 'ProductionInDetail')}" />
	<title><g:message code="default.show.label" args="[entityName]" /></title>
</head>

<body>

<section id="show-productionInDetail" class="first">
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
								<td valign="top" class="name"><g:message code="productionInDetail.updatedBy.label" default="Updated By" /></td>
								
								<td valign="top" class="value">${fieldValue(bean: productionInDetailInstance, field: "updatedBy")}</td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="productionInDetail.createdBy.label" default="Created By" /></td>
								
								<td valign="top" class="value">${fieldValue(bean: productionInDetailInstance, field: "createdBy")}</td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="productionInDetail.dateCreated.label" default="Date Created" /></td>
								
								<td valign="top" class="value"><g:formatDate date="${productionInDetailInstance?.dateCreated}" /></td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="productionInDetail.gallon.label" default="Gallon" /></td>
								
								<td valign="top" class="value"><g:link controller="gallon" action="show" id="${productionInDetailInstance?.gallon?.id}">${productionInDetailInstance?.gallon?.encodeAsHTML()}</g:link></td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="productionInDetail.lastUpdated.label" default="Last Updated" /></td>
								
								<td valign="top" class="value"><g:formatDate date="${productionInDetailInstance?.lastUpdated}" /></td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="productionInDetail.productionInHeader.label" default="Production In Header" /></td>
								
								<td valign="top" class="value"><g:link controller="productionInHeader" action="show" id="${productionInDetailInstance?.productionInHeader?.id}">${productionInDetailInstance?.productionInHeader?.encodeAsHTML()}</g:link></td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="productionInDetail.serverId.label" default="Server Id" /></td>
								
								<td valign="top" class="value">${fieldValue(bean: productionInDetailInstance, field: "serverId")}</td>
								
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
