
<%@ page import="com.smanggin.trackingmanagement.ProductionInDetail" %>
<!doctype html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'productionInDetail.label', default: 'ProductionInDetail')}" />
	<title><g:message code="default.list.label" args="[entityName]" /></title>
</head>

<body>
	
<section id="list-productionInDetail" class="first">
	<div class="row">
		<div class="col-lg-12">
			<div class="box box-primary">
				
				<div class="box-header with-border">
                  <h3 class="box-title"><g:message code="default.list.label" args="[entityName]" /></h3>
                </div><!--/.box-header with-border -->

				<div class="box-body table-responsive">	
					<table class="table table-bordered margin-top-medium">
						<thead>
							<tr>
							
								<g:sortableColumn property="updatedBy" title="${message(code: 'productionInDetail.updatedBy.label', default: 'Updated By')}" />
							
								<g:sortableColumn property="createdBy" title="${message(code: 'productionInDetail.createdBy.label', default: 'Created By')}" />
							
								<g:sortableColumn property="dateCreated" title="${message(code: 'productionInDetail.dateCreated.label', default: 'Date Created')}" />
							
								<th><g:message code="productionInDetail.gallon.label" default="Gallon" /></th>
							
								<g:sortableColumn property="lastUpdated" title="${message(code: 'productionInDetail.lastUpdated.label', default: 'Last Updated')}" />
							
								<th><g:message code="productionInDetail.productionInHeader.label" default="Production In Header" /></th>
							
							</tr>
						</thead>
						<tbody>
						<g:each in="${productionInDetailInstanceList}" status="i" var="productionInDetailInstance">
							<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
							
								<td><g:link action="show" id="${productionInDetailInstance.id}">${fieldValue(bean: productionInDetailInstance, field: "updatedBy")}</g:link></td>
							
								<td>${fieldValue(bean: productionInDetailInstance, field: "createdBy")}</td>
							
								<td><g:formatDate date="${productionInDetailInstance.dateCreated}" /></td>
							
								<td>${fieldValue(bean: productionInDetailInstance, field: "gallon")}</td>
							
								<td><g:formatDate date="${productionInDetailInstance.lastUpdated}" /></td>
							
								<td>${fieldValue(bean: productionInDetailInstance, field: "productionInHeader")}</td>
							
							</tr>
						</g:each>
						</tbody>
					</table>
				</div><!--/.box-body table-responsive -->

				<div class="box-footer clearfix">
					<bs:paginate total="${productionInDetailInstanceTotal}" />
				</div><!--/.box-footer clearfix -->
			</div><!--/.box box-primary -->	
		</div><!--/.col-lg-12 -->	
	</div><!--/.row -->			

</section>

</body>

</html>
