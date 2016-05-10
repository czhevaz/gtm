
<%@ page import="com.smanggin.trackingmanagement.WorkCenter" %>
<!doctype html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'workCenter.label', default: 'WorkCenter')}" />
	<title><g:message code="default.list.label" args="[entityName]" /></title>
</head>

<body>
	
<section id="list-workCenter" class="first">
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
								<td> No. </td>

								<g:sortableColumn property="name" title="${message(code: 'workCenter.name.label', default: 'Name')}" />
							
								<th><g:message code="workCenter.line.label" default="Plant" /></th>

								<th><g:message code="workCenter.line.label" default="Line" /></th>

								<th><g:message code="workCenter.line.label" default="Process" /></th>

								<g:sortableColumn property="updatedBy" title="${message(code: 'workCenter.updatedBy.label', default: 'Updated By')}" />
							
								<g:sortableColumn property="createdBy" title="${message(code: 'workCenter.createdBy.label', default: 'Created By')}" />
							
								<g:sortableColumn property="dateCreated" title="${message(code: 'workCenter.dateCreated.label', default: 'Date Created')}" />
							
								<g:sortableColumn property="lastUpdated" title="${message(code: 'workCenter.lastUpdated.label', default: 'Last Updated')}" />
							
								
							
							</tr>
						</thead>
						<tbody>
						<g:each in="${workCenterInstanceList}" status="i" var="workCenterInstance">
							<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

								<td>${i+1}</td>

								<td><g:link action="show" params="[serverId:workCenterInstance.serverId]">${fieldValue(bean: workCenterInstance, field: "name")}</g:link></td>
								
								<td>${fieldValue(bean: workCenterInstance, field: "plant")}</td>

								<td>${fieldValue(bean: workCenterInstance, field: "line")}</td>

								<td>${fieldValue(bean: workCenterInstance, field: "process")}</td>

								<td>${fieldValue(bean: workCenterInstance, field: "updatedBy")}</td>
							
								<td>${fieldValue(bean: workCenterInstance, field: "createdBy")}</td>
							
								<td><g:formatDate date="${workCenterInstance.dateCreated}" /></td>
							
								<td><g:formatDate date="${workCenterInstance.lastUpdated}" /></td>
							
								
							
							</tr>
						</g:each>
						</tbody>
					</table>
				</div><!--/.box-body table-responsive -->

				<div class="box-footer clearfix">
					<bs:paginate total="${workCenterInstanceTotal}" />
				</div><!--/.box-footer clearfix -->
			</div><!--/.box box-primary -->	
		</div><!--/.col-lg-12 -->	
	</div><!--/.row -->			

</section>

</body>

</html>
