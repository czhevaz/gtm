
<%@ page import="com.smanggin.trackingmanagement.QCHeader" %>
<!doctype html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'QCHeader.label', default: 'QCHeader')}" />
	<title><g:message code="default.list.label" args="[entityName]" /></title>
</head>

<body>
	
<section id="list-QCHeader" class="first">
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
							
								<th><g:message code="QCHeader.number.label" default="Number" /></th>
								
								<th><g:message code="QCHeader.transactionGroup.label" default="TransactionGroup" /></th>

								<th><g:message code="QCHeader.plant.label" default="Plant" /></th>

								<th><g:message code="QCHeader.workCenter.label" default="Work Center" /></th>

								<g:sortableColumn property="date" title="${message(code: 'QCHeader.date.label', default: 'Date')}" />
							
								<th><g:message code="QCHeader.gallon.label" default="Gallon" /></th>
							
							</tr>
						</thead>
						<tbody>
						<g:each in="${QCHeaderInstanceList}" status="i" var="QCHeaderInstance">
							<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
							
								<td> <g:link action="show" params="[serverId:QCHeaderInstance?.serverId]">${fieldValue(bean: QCHeaderInstance, field: "number")}</g:link></td>

								<td>${fieldValue(bean: QCHeaderInstance, field: "transactionGroup")}</td>

								<td>${fieldValue(bean: QCHeaderInstance, field: "plant")}</td>

								<td>${fieldValue(bean: QCHeaderInstance, field: "workCenter")}</td>

								<td><g:formatDate date="${QCHeaderInstance.date}" /></td>
							
								<td>${fieldValue(bean: QCHeaderInstance, field: "gallon")}</td>
							
							
							
							</tr>
						</g:each>
						</tbody>
					</table>
				</div><!--/.box-body table-responsive -->

				<div class="box-footer clearfix">
					<bs:paginate total="${QCHeaderInstanceTotal}" />
				</div><!--/.box-footer clearfix -->
			</div><!--/.box box-primary -->	
		</div><!--/.col-lg-12 -->	
	</div><!--/.row -->			

</section>

</body>

</html>
