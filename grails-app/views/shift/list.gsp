
<%@ page import="com.smanggin.trackingmanagement.Shift" %>
<!doctype html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'shift.label', default: 'Shift')}" />
	<title><g:message code="default.list.label" args="[entityName]" /></title>
</head>

<body>
	
<section id="list-shift" class="first">
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
							
								<g:sortableColumn property="name" title="${message(code: 'shift.name.label', default: 'Name')}" />
								<g:sortableColumn property="description" title="${message(code: 'shift.description.label', default: 'Description')}" />
								<g:sortableColumn property="startDate" title="${message(code: 'shift.startDate.label', default: 'Start Date')}" />
								<g:sortableColumn property="endDate" title="${message(code: 'shift.endDate.label', default: 'End Date')}" />
							
							</tr>
						</thead>
						<tbody>
						<g:each in="${shiftInstanceList}" status="i" var="shiftInstance">
							<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
								<td>${fieldValue(bean: shiftInstance, field: "name")}</td>
								
								<td>${fieldValue(bean: shiftInstance, field: "description")}</td>
							
								<td>${shiftInstance.startDate}</td>
							
								<td>${shiftInstance.endDate}</td>
							
							</tr>
						</g:each>
						</tbody>
					</table>
				</div><!--/.box-body table-responsive -->

				<div class="box-footer clearfix">
					<bs:paginate total="${shiftInstanceTotal}" />
				</div><!--/.box-footer clearfix -->
			</div><!--/.box box-primary -->	
		</div><!--/.col-lg-12 -->	
	</div><!--/.row -->			

</section>

</body>

</html>
