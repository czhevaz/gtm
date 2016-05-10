
<%@ page import="com.smanggin.trackingmanagement.CloseShift" %>
<!doctype html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'closeShift.label', default: 'CloseShift')}" />
	<title><g:message code="default.list.label" args="[entityName]" /></title>
</head>

<body>
	
<section id="list-closeShift" class="first">
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
							
								<g:sortableColumn property="closeDate" title="${message(code: 'closeShift.closeDate.label', default: 'Close Date')}" />
							
								<g:sortableColumn property="dateCreated" title="${message(code: 'closeShift.dateCreated.label', default: 'Date Created')}" />
							
								<g:sortableColumn property="lastUpdated" title="${message(code: 'closeShift.lastUpdated.label', default: 'Last Updated')}" />
							
								<th><g:message code="closeShift.line.label" default="Line" /></th>
							
								<g:sortableColumn property="serverId" title="${message(code: 'closeShift.serverId.label', default: 'Server Id')}" />
							
								<th><g:message code="closeShift.shift.label" default="Shift" /></th>
							
							</tr>
						</thead>
						<tbody>
						<g:each in="${closeShiftInstanceList}" status="i" var="closeShiftInstance">
							<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
							
								<td><g:link action="show" id="${closeShiftInstance.id}">${fieldValue(bean: closeShiftInstance, field: "closeDate")}</g:link></td>
							
								<td><g:formatDate date="${closeShiftInstance.dateCreated}" /></td>
							
								<td><g:formatDate date="${closeShiftInstance.lastUpdated}" /></td>
							
								<td>${fieldValue(bean: closeShiftInstance, field: "line")}</td>
							
								<td>${fieldValue(bean: closeShiftInstance, field: "serverId")}</td>
							
								<td>${fieldValue(bean: closeShiftInstance, field: "shift")}</td>
							
							</tr>
						</g:each>
						</tbody>
					</table>
				</div><!--/.box-body table-responsive -->

				<div class="box-footer clearfix">
					<bs:paginate total="${closeShiftInstanceTotal}" />
				</div><!--/.box-footer clearfix -->
			</div><!--/.box box-primary -->	
		</div><!--/.col-lg-12 -->	
	</div><!--/.row -->			

</section>

</body>

</html>
