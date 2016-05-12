
<%@ page import="com.smanggin.trackingmanagement.ProductionInHeader" %>
<!doctype html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'productionInHeader.label', default: 'Production In Header')}" />
	<title><g:message code="default.list.label" args="[entityName]" /></title>
</head>

<body>
	
<section id="list-productionInHeader" class="first">
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
								<g:sortableColumn property="number" title="${message(code: 'productionInHeader.number.label', default: 'Number')}" />

								<th>${message(code: 'productionInHeader.plant.label', default: 'Plant')}</th>

								<th>${message(code: 'productionInHeader.workCenter.label', default: 'WorkCenter')}</th>

								<th>${message(code: 'productionInHeader.shift.label', default: 'Shift')}</th>

								<th>${message(code: 'productionInHeader.item.label', default: 'Item')}</th>

								<th>${message(code: 'productionInHeader.transactionGroup.label', default: 'transactionGroup')}</th>

								<g:sortableColumn property="date" title="${message(code: 'productionInHeader.date.label', default: 'Date')}" />

								<th>${message(code: 'productionInHeader.totalGallon.label', default: 'Total')}</th>
								
								
							
							</tr>
						</thead>
						<tbody>
						<g:each in="${productionInHeaderInstanceList}" status="i" var="productionInHeaderInstance">
							<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
							
								<td><g:link action="show" id="${productionInHeaderInstance.serverId}">${fieldValue(bean: productionInHeaderInstance, field: "number")}</g:link></td>

								<td>${fieldValue(bean: productionInHeaderInstance, field: "plant")}</td>

								<td>${fieldValue(bean: productionInHeaderInstance, field: "workCenter")}</td>

								<td>${fieldValue(bean: productionInHeaderInstance, field: "shift")}</td>

								<td>${fieldValue(bean: productionInHeaderInstance, field: "item")}</td>

								<td>${fieldValue(bean: productionInHeaderInstance, field: "transactionGroup")}</td>

								<td><g:formatDate date="${productionInHeaderInstance.date}" /></td>

								<td>${fieldValue(bean: productionInHeaderInstance, field: "totalGallon")}</td>
							
							</tr>
						</g:each>
						</tbody>
					</table>
				</div><!--/.box-body table-responsive -->

				<div class="box-footer clearfix">
					<bs:paginate total="${productionInHeaderInstanceTotal}" />
				</div><!--/.box-footer clearfix -->
			</div><!--/.box box-primary -->	
		</div><!--/.col-lg-12 -->	
	</div><!--/.row -->			

</section>

</body>

</html>
