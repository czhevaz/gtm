
<%@ page import="com.smanggin.trackingmanagement.CloseShift" %>
<!doctype html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'closeShift.label', default: 'Shift Closing')}" />
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
					<table class="table table-bordered margin-top-medium dataTablesList">
						<thead>
							<tr>
								
								<th>No</th>
								<g:sortableColumn property="closeDate" title="${message(code: 'closeShift.closeDate.label', default: 'Close Date')}" />
							
								<th><g:message code="closeShift.line.label" default="Line" /></th>
							
								<th><g:message code="closeShift.shift.label" default="Shift" /></th>
								
								<th><g:message code="closeShift.item.label" default="item" /></th>
								
								<th><g:message code="closeShift.yieldBySystem.label" default="yieldBySystem" /></th>

								<th><g:message code="closeShift.yieldByUser.label" default="yieldByUser" /></th>
							
							</tr>
						</thead>
						<tfoot>
							<tr>
								
								<th>No</th>
								<g:sortableColumn property="closeDate" title="${message(code: 'closeShift.closeDate.label', default: 'Close Date')}" />
							
								<th><g:message code="closeShift.line.label" default="Line" /></th>
							
								<th><g:message code="closeShift.shift.label" default="Shift" /></th>
								
								<th><g:message code="closeShift.item.label" default="item" /></th>
								
								<th><g:message code="closeShift.yieldBySystem.label" default="yieldBySystem" /></th>

								<th><g:message code="closeShift.yieldByUser.label" default="yieldByUser" /></th>
							
							</tr>
						</tfoot>
						<tbody>
						<g:each in="${closeShiftInstanceList}" status="i" var="closeShiftInstance">
							<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
							
								<td>${1+i}</td>

								<td>${fieldValue(bean: closeShiftInstance, field: "closeDate")}</td>
							
								<td>${fieldValue(bean: closeShiftInstance, field: "line")}</td>	
								
								<td>${fieldValue(bean: closeShiftInstance, field: "shift")}</td>
								
								<td>${fieldValue(bean: closeShiftInstance, field: "item")}</td>

								<td>${fieldValue(bean: closeShiftInstance, field: "yieldBySystem")}</td>

								<td>${fieldValue(bean: closeShiftInstance, field: "yieldByUser")}</td>
								
							</tr>
						</g:each>
						</tbody>
					</table>
				</div><!--/.box-body table-responsive -->
				<!--
				<div class="box-footer clearfix">
					<bs:paginate total="${closeShiftInstanceTotal}" />
				</div><!--/.box-footer clearfix -->
			</div><!--/.box box-primary -->	
		</div><!--/.col-lg-12 -->	
	</div><!--/.row -->			

</section>

</body>

</html>
