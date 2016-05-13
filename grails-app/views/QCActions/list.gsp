
<%@ page import="com.smanggin.trackingmanagement.QCActions" %>
<!doctype html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'QCActions.label', default: 'QCActions')}" />
	<title><g:message code="default.list.label" args="[entityName]" /></title>
</head>

<body>
	
<section id="list-QCActions" class="first">
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
							
								
							
								<g:sortableColumn property="description" title="${message(code: 'QCActions.description.label', default: 'Description')}" />
							
								
								<g:sortableColumn property="createdBy" title="${message(code: 'QCActions.createdBy.label', default: 'Created By')}" />
							
								<g:sortableColumn property="dateCreated" title="${message(code: 'QCActions.dateCreated.label', default: 'Date Created')}" />

								<g:sortableColumn property="updatedBy" title="${message(code: 'QCActions.updatedBy.label', default: 'Updated By')}" />
							
							
								<g:sortableColumn property="lastUpdated" title="${message(code: 'QCActions.lastUpdated.label', default: 'Last Updated')}" />
							
							</tr>
						</thead>
						<tbody>
						<g:each in="${QCActionsInstanceList}" status="i" var="QCActionsInstance">
							<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
							
								
							
								<td><g:link action="show" id="${QCActionsInstance.id}">${fieldValue(bean: QCActionsInstance, field: "description")}</g:link></td>
							
								
							
								<td>${fieldValue(bean: QCActionsInstance, field: "createdBy")}</td>
							
								<td><g:formatDate date="${QCActionsInstance.dateCreated}" /></td>
								
								<td>${fieldValue(bean: QCActionsInstance, field: "updatedBy")}</td>
								
								<td><g:formatDate date="${QCActionsInstance.lastUpdated}" /></td>
							
							</tr>
						</g:each>
						</tbody>
					</table>
				</div><!--/.box-body table-responsive -->

				<div class="box-footer clearfix">
					<bs:paginate total="${QCActionsInstanceTotal}" />
				</div><!--/.box-footer clearfix -->
			</div><!--/.box box-primary -->	
		</div><!--/.col-lg-12 -->	
	</div><!--/.row -->			

</section>

</body>

</html>
