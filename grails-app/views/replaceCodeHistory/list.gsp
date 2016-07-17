
<%@ page import="com.smanggin.trackingmanagement.ReplaceCodeHistory" %>
<!doctype html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'replaceCodeHistory.label', default: 'ReplaceCodeHistory')}" />
	<title><g:message code="default.list.label" args="[entityName]" /></title>
</head>

<body>
	
<section id="list-replaceCodeHistory" class="first">
	<div class="row">
		<div class="col-lg-12">
			<div class="box box-primary">
				
				<div class="box-header with-border">
                  <h3 class="box-title"><g:message code="default.list.label" args="[entityName]" /></h3>
                </div><!--/.box-header with-border -->

				<div class="box-body table-responsive">	
					<table class="table table-bordered margin-top-medium dataTablesList">
						<thead>
							<tr>
								<th>No</th>

								<th><g:message code="replaceCodeHistory.gallon.label" default="Gallon" /></th>
							
								<g:sortableColumn property="createdBy" title="${message(code: 'replaceCodeHistory.createdBy.label', default: 'Created By')}" />
							
								<g:sortableColumn property="dateCreated" title="${message(code: 'replaceCodeHistory.dateCreated.label', default: 'Date Created')}" />
							
								<g:sortableColumn property="lastUpdated" title="${message(code: 'replaceCodeHistory.lastUpdated.label', default: 'Last Updated')}" />
							
								<g:sortableColumn property="newNumber" title="${message(code: 'replaceCodeHistory.newNumber.label', default: 'New Number')}" />
							
								<g:sortableColumn property="oldNumber" title="${message(code: 'replaceCodeHistory.oldNumber.label', default: 'Old Number')}" />
							
							</tr>
						</thead>
						<tfoot>
							<tr>
								<th>No</th>
								
								<th><g:message code="replaceCodeHistory.gallon.label" default="Gallon" /></th>
							
								<g:sortableColumn property="createdBy" title="${message(code: 'replaceCodeHistory.createdBy.label', default: 'Created By')}" />
							
								<g:sortableColumn property="dateCreated" title="${message(code: 'replaceCodeHistory.dateCreated.label', default: 'Date Created')}" />
							
								<g:sortableColumn property="lastUpdated" title="${message(code: 'replaceCodeHistory.lastUpdated.label', default: 'Last Updated')}" />
							
								<g:sortableColumn property="newNumber" title="${message(code: 'replaceCodeHistory.newNumber.label', default: 'New Number')}" />
							
								<g:sortableColumn property="oldNumber" title="${message(code: 'replaceCodeHistory.oldNumber.label', default: 'Old Number')}" />
							
							</tr>
						</tfoot>
						<tbody>
						<g:each in="${replaceCodeHistoryInstanceList}" status="i" var="replaceCodeHistoryInstance">
							<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
								<td>${i+1}</td>
								<td><g:link action="show" id="${replaceCodeHistoryInstance.id}">${fieldValue(bean: replaceCodeHistoryInstance, field: "gallon")}</g:link></td>
							
								<td>${fieldValue(bean: replaceCodeHistoryInstance, field: "createdBy")}</td>
							
								<td><g:formatDate date="${replaceCodeHistoryInstance.dateCreated}" /></td>
							
								<td><g:formatDate date="${replaceCodeHistoryInstance.lastUpdated}" /></td>
							
								<td>${fieldValue(bean: replaceCodeHistoryInstance, field: "newNumber")}</td>
							
								<td>${fieldValue(bean: replaceCodeHistoryInstance, field: "oldNumber")}</td>
							
							</tr>
						</g:each>
						</tbody>
					</table>
				</div><!--/.box-body table-responsive -->

				<!--
				<div class="box-footer clearfix">
					<bs:paginate total="${replaceCodeHistoryInstanceTotal}" />
				</div><!--/.box-footer clearfix -->
			</div><!--/.box box-primary -->	
		</div><!--/.col-lg-12 -->	
	</div><!--/.row -->			

</section>

</body>

</html>
