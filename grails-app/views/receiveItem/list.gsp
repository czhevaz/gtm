
<%@ page import="com.smanggin.trackingmanagement.ReceiveItem" %>
<!doctype html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'receiveItem.label', default: 'ReceiveItem')}" />
	<title><g:message code="default.list.label" args="[entityName]" /></title>
</head>

<body>
	
<section id="list-receiveItem" class="first">
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

								<th>supplier</th>
								
								<g:sortableColumn property="endNumber" title="${message(code: 'receiveItem.shift.label', default: 'Shift')}" />

								<g:sortableColumn property="groupShift" title="${message(code: 'receiveItem.groupShift.label', default: 'Group Shift')}" />	

								<g:sortableColumn property="endNumber" title="${message(code: 'receiveItem.productionLine.label', default: 'Production Line')}" />
								
								<th>Receive Date</th>

								
															
								
							</tr>
						</thead>
						<tfoot>
							<tr>
								<th>No</th>

								<th>supplier</th>
								
								<g:sortableColumn property="endNumber" title="${message(code: 'receiveItem.shift.label', default: 'Shift')}" />

								<g:sortableColumn property="groupShift" title="${message(code: 'receiveItem.groupShift.label', default: 'Group Shift')}" />	

								<g:sortableColumn property="endNumber" title="${message(code: 'receiveItem.productionLine.label', default: 'Production Line')}" />
								
								<th>Receive Date</th>
							
								
							</tr>
						</tfoot>
						<tbody>
						<g:each in="${receiveItemInstanceList}" status="i" var="receiveItemInstance">
							<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
							
								<td> ${i+1}</td>
								<td><g:link action="show" params="['serverId':receiveItemInstance.serverId]">${fieldValue(bean: receiveItemInstance, field: "supplier")}</g:link></td>
							
								
								<td>${fieldValue(bean: receiveItemInstance, field: "shift")}</td>

								<td>${fieldValue(bean: receiveItemInstance, field: "groupShift")}</td>

								<td>${fieldValue(bean: receiveItemInstance, field: "productionLine")}</td>

								<td>${fieldValue(bean: receiveItemInstance, field: "receivedDate")}</td>
	
							</tr>
						</g:each>
						</tbody>
					</table>
				</div><!--/.box-body table-responsive -->
				<!--
				<div class="box-footer clearfix">
					<bs:paginate total="${receiveItemInstanceTotal}" />
				</div><!--/.box-footer clearfix -->
			</div><!--/.box box-primary -->	
		</div><!--/.col-lg-12 -->	
	</div><!--/.row -->			

</section>

</body>

</html>
