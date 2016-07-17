
<%@ page import="com.smanggin.trackingmanagement.Item" %>
<!doctype html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'item.label', default: 'Item')}" />
	<title><g:message code="default.list.label" args="[entityName]" /></title>
</head>

<body>
	
<section id="list-item" class="first">
	<div class="row">
		<div class="col-lg-12">
			<div class="box box-primary">
				
				<div class="box-header with-border">plant
                  <h3 class="box-title"><g:message code="default.list.label" args="[entityName]" /></h3>
                </div><!--/.box-header with-border -->

				<div class="box-body table-responsive">	
					<table class="table table-bordered margin-top-medium dataTablesList">
						<thead>
							<tr>
								<th>No</th>
								<g:sortableColumn property="name" title="${message(code: 'item.name.label', default: 'Name')}" />

								<g:sortableColumn property="description" title="${message(code: 'item.description.label', default: 'Description')}" />

								<g:sortableColumn property="dateCreated" title="${message(code: 'item.dateCreated.label', default: 'Date Created')}" />
							
								<g:sortableColumn property="lastUpdated" title="${message(code: 'item.lastUpdated.label', default: 'Last Updated')}" />
							
							</tr>
						</thead>
						<tbody>
						<tfoot>
							<tr>
								<th>No</th>
								<g:sortableColumn property="name" title="${message(code: 'item.name.label', default: 'Name')}" />

								<g:sortableColumn property="description" title="${message(code: 'item.description.label', default: 'Description')}" />

								<g:sortableColumn property="dateCreated" title="${message(code: 'item.dateCreated.label', default: 'Date Created')}" />
							
								<g:sortableColumn property="lastUpdated" title="${message(code: 'item.lastUpdated.label', default: 'Last Updated')}" />
							
							</tr>
						</tfoot>
						<g:each in="${itemInstanceList}" status="i" var="itemInstance">
							<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
								<td>${i+1}</td>
								<td><g:link action="show" params="[serverId:itemInstance?.serverId]">${fieldValue(bean: itemInstance, field: "name")}</g:link></td>

								<td>${fieldValue(bean: itemInstance, field: "description")}</td>
								
								<td>${fieldValue(bean: itemInstance, field: "dateCreated")}</td>
							
								<td><g:formatDate date="${itemInstance.lastUpdated}" /></td>
							
							</tr>
						</g:each>
						</tbody>
					</table>
				</div><!--/.box-body table-responsive -->
				<!--
				<div class="box-footer clearfix">
					<bs:paginate total="${itemInstanceTotal}" />
				</div><!--/.box-footer clearfix -->
			</div><!--/.box box-primary -->	
		</div><!--/.col-lg-12 -->	
	</div><!--/.row -->			

</section>

</body>

</html>
