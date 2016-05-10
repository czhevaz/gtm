
<%@ page import="com.smanggin.trackingmanagement.QCOptions" %>
<!doctype html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'QCOptions.label', default: 'QCOptions')}" />
	<title><g:message code="default.list.label" args="[entityName]" /></title>
</head>

<body>
	
<section id="list-QCOptions" class="first">
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
							
								<g:sortableColumn property="description" title="${message(code: 'QCOptions.description.label', default: 'Description')}" />
							
								<g:sortableColumn property="updatedBy" title="${message(code: 'QCOptions.updatedBy.label', default: 'Updated By')}" />
							
								<g:sortableColumn property="createdBy" title="${message(code: 'QCOptions.createdBy.label', default: 'Created By')}" />
							
								<g:sortableColumn property="dateCreated" title="${message(code: 'QCOptions.dateCreated.label', default: 'Date Created')}" />
							
								<g:sortableColumn property="lastUpdated" title="${message(code: 'QCOptions.lastUpdated.label', default: 'Last Updated')}" />
							
							
							</tr>
						</thead>
						<tbody>
						<g:each in="${QCOptionsInstanceList}" status="i" var="QCOptionsInstance">
							<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
							
								<td><g:link action="show" params="[serverId:QCOptionsInstance?.serverId]">${fieldValue(bean: QCOptionsInstance, field: "description")}</g:link></td>
							
								<td>${fieldValue(bean: QCOptionsInstance, field: "updatedBy")}</td>
							
								<td>${fieldValue(bean: QCOptionsInstance, field: "createdBy")}</td>
							
								<td><g:formatDate date="${QCOptionsInstance.dateCreated}" /></td>
							
								<td><g:formatDate date="${QCOptionsInstance.lastUpdated}" /></td>
							

							
							</tr>
						</g:each>
						</tbody>
					</table>
				</div><!--/.box-body table-responsive -->

				<div class="box-footer clearfix">
					<bs:paginate total="${QCOptionsInstanceTotal}" />
				</div><!--/.box-footer clearfix -->
			</div><!--/.box box-primary -->	
		</div><!--/.col-lg-12 -->	
	</div><!--/.row -->			

</section>

</body>

</html>
