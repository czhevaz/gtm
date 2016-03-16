
<%@ page import="com.smanggin.trackingmanagement.Process" %>
<!doctype html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'process.label', default: 'Process')}" />
	<title><g:message code="default.list.label" args="[entityName]" /></title>
</head>

<body>
	
<section id="list-process" class="first">
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
							
								
						
								<g:sortableColumn property="code" title="${message(code: 'process.code.label', default: 'Code')}" />
							
								<g:sortableColumn property="name" title="${message(code: 'process.name.label', default: 'Name')}" />
							
								<g:sortableColumn property="updatedBy" title="${message(code: 'process.updatedBy.label', default: 'Updated By')}" />
							
								<g:sortableColumn property="createdBy" title="${message(code: 'process.createdBy.label', default: 'Created By')}" />
							
								<g:sortableColumn property="dateCreated" title="${message(code: 'process.dateCreated.label', default: 'Date Created')}" />
							
							</tr>
						</thead>
						<tbody>
						<g:each in="${processInstanceList}" status="i" var="processInstance">
							<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
							
								
							
								<td><g:link action="show" params="[serverId:processInstance.serverId]">${fieldValue(bean: processInstance, field: "code")}</g:link></td>
							
								<td>${fieldValue(bean: processInstance, field: "name")}</td>
							
								<td>${fieldValue(bean: processInstance, field: "updatedBy")}</td>
							
								<td>${fieldValue(bean: processInstance, field: "createdBy")}</td>
							
								<td><g:formatDate date="${processInstance.dateCreated}" /></td>
							
							</tr>
						</g:each>
						</tbody>
					</table>
				</div><!--/.box-body table-responsive -->

				<div class="box-footer clearfix">
					<bs:paginate total="${processInstanceTotal}" />
				</div><!--/.box-footer clearfix -->
			</div><!--/.box box-primary -->	
		</div><!--/.col-lg-12 -->	
	</div><!--/.row -->			

</section>

</body>

</html>
