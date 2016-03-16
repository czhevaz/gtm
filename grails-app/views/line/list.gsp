
<%@ page import="com.smanggin.trackingmanagement.Line" %>
<!doctype html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'line.label', default: 'Line')}" />
	<title><g:message code="default.list.label" args="[entityName]" /></title>
</head>

<body>
	
<section id="list-line" class="first">
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
							
								<g:sortableColumn property="serverId" title="${message(code: 'line.serverId.label', default: 'Server Id')}" />
							
								<g:sortableColumn property="code" title="${message(code: 'line.code.label', default: 'Code')}" />
							
								<g:sortableColumn property="name" title="${message(code: 'line.name.label', default: 'Name')}" />
							
								<g:sortableColumn property="updatedBy" title="${message(code: 'line.updatedBy.label', default: 'Updated By')}" />
							
								<g:sortableColumn property="createdBy" title="${message(code: 'line.createdBy.label', default: 'Created By')}" />
							
								<g:sortableColumn property="dateCreated" title="${message(code: 'line.dateCreated.label', default: 'Date Created')}" />
							
							</tr>
						</thead>
						<tbody>
						<g:each in="${lineInstanceList}" status="i" var="lineInstance">
							<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
							
								<td><g:link action="show" params="[serverId:lineInstance?.serverId]">${fieldValue(bean: lineInstance, field: "serverId")}</g:link></td>
							
								<td>${fieldValue(bean: lineInstance, field: "code")}</td>
							
								<td>${fieldValue(bean: lineInstance, field: "name")}</td>
							
								<td>${fieldValue(bean: lineInstance, field: "updatedBy")}</td>
							
								<td>${fieldValue(bean: lineInstance, field: "createdBy")}</td>
							
								<td><g:formatDate date="${lineInstance.dateCreated}" /></td>
							
							</tr>
						</g:each>
						</tbody>
					</table>
				</div><!--/.box-body table-responsive -->

				<div class="box-footer clearfix">
					<bs:paginate total="${lineInstanceTotal}" />
				</div><!--/.box-footer clearfix -->
			</div><!--/.box box-primary -->	
		</div><!--/.col-lg-12 -->	
	</div><!--/.row -->			

</section>

</body>

</html>
