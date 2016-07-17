
<%@ page import="com.smanggin.trackingmanagement.QcAfkir" %>
<!doctype html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: session.trType=='1'?'qcRejected.label':'qcAfkir.label', default: 'QcAfkir')}" />
	<title><g:message code="default.list.label" args="[entityName]" /></title>
</head>

<body>
	
<section id="list-qcAfkir" class="first">
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
								<th><g:message code="qcAfkir.number.label" default="Number" /></th>

								<th><g:message code="qcAfkir.shift.label" default="Shift" /></th>
							
								<th><g:message code="qcAfkir.item.label" default="Item" /></th>

								<th>Plant</th>

								<th>Line</th>

								<th>Shift</th>
							
								<g:sortableColumn property="description" title="${message(code: 'qcAfkir.description.label', default: 'Description')}" />
							
								<g:sortableColumn property="date" title="${message(code: 'qcAfkir.date.label', default: 'Date')}" />
							
							</tr>
						</thead>
						<tfoot>
							<tr>
							
								<th>No</th>
								<th><g:message code="qcAfkir.number.label" default="Number" /></th>

								<th><g:message code="qcAfkir.shift.label" default="Shift" /></th>
							
								<th><g:message code="qcAfkir.item.label" default="Item" /></th>

								<th>Plant</th>

								<th>Line</th>

								<th>Shift</th>
							
								<g:sortableColumn property="description" title="${message(code: 'qcAfkir.description.label', default: 'Description')}" />
							
								<g:sortableColumn property="date" title="${message(code: 'qcAfkir.date.label', default: 'Date')}" />
							
							</tr>
						</tfoot>
						<tbody>
						<g:each in="${qcAfkirInstanceList}" status="i" var="qcAfkirInstance">
							<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
								<td>${1+i}</td>
								<td><g:link action="show" params="[serverId:qcAfkirInstance.serverId]">${fieldValue(bean: qcAfkirInstance, field: "number")}</g:link></td>
							
								<td>${fieldValue(bean: qcAfkirInstance, field: "shift")}</td>
							
								<td>${fieldValue(bean: qcAfkirInstance, field: "item")}</td>

								<td>${fieldValue(bean: qcAfkirInstance, field: "plant")}</td>

								<td>${qcAfkirInstance.workCenter.line}</td>

								<td>${qcAfkirInstance.shift}</td>								
							
								<td>${fieldValue(bean: qcAfkirInstance, field: "description")}</td>
							
								<td><g:formatDate date="${qcAfkirInstance.date}" /></td>
							
							</tr>
						</g:each>
						</tbody>
					</table>
				</div><!--/.box-body table-responsive -->
				<!--
				<div class="box-footer clearfix">
					<bs:paginate total="${qcAfkirInstanceTotal}" />
				</div><!--/.box-footer clearfix -->
			</div><!--/.box box-primary -->	
		</div><!--/.col-lg-12 -->	
	</div><!--/.row -->			

</section>

</body>

</html>
