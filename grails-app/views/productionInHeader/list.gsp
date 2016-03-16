
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
							
								<g:sortableColumn property="updatedBy" title="${message(code: 'productionInHeader.updatedBy.label', default: 'Updated By')}" />
							
								<g:sortableColumn property="createdBy" title="${message(code: 'productionInHeader.createdBy.label', default: 'Created By')}" />
							
								<g:sortableColumn property="date" title="${message(code: 'productionInHeader.date.label', default: 'Date')}" />
							
								<g:sortableColumn property="dateCreated" title="${message(code: 'productionInHeader.dateCreated.label', default: 'Date Created')}" />
							
								<g:sortableColumn property="lastUpdated" title="${message(code: 'productionInHeader.lastUpdated.label', default: 'Last Updated')}" />
							
								<g:sortableColumn property="number" title="${message(code: 'productionInHeader.number.label', default: 'Number')}" />
							
							</tr>
						</thead>
						<tbody>
						<g:each in="${productionInHeaderInstanceList}" status="i" var="productionInHeaderInstance">
							<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
							
								<td><g:link action="show" id="${productionInHeaderInstance.serverId}">${fieldValue(bean: productionInHeaderInstance, field: "updatedBy")}</g:link></td>
							
								<td>${fieldValue(bean: productionInHeaderInstance, field: "createdBy")}</td>
							
								<td><g:formatDate date="${productionInHeaderInstance.date}" /></td>
							
								<td><g:formatDate date="${productionInHeaderInstance.dateCreated}" /></td>
							
								<td><g:formatDate date="${productionInHeaderInstance.lastUpdated}" /></td>
							
								<td>${fieldValue(bean: productionInHeaderInstance, field: "number")}</td>
							
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
