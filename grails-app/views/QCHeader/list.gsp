
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
							
								<g:sortableColumn property="updatedBy" title="${message(code: 'QCHeader.updatedBy.label', default: 'Updated By')}" />
							
								<g:sortableColumn property="createdBy" title="${message(code: 'QCHeader.createdBy.label', default: 'Created By')}" />
							
								<g:sortableColumn property="date" title="${message(code: 'QCHeader.date.label', default: 'Date')}" />
							
								<g:sortableColumn property="dateCreated" title="${message(code: 'QCHeader.dateCreated.label', default: 'Date Created')}" />
							
								<th><g:message code="QCHeader.gallon.label" default="Gallon" /></th>
							
								<g:sortableColumn property="lastUpdated" title="${message(code: 'QCHeader.lastUpdated.label', default: 'Last Updated')}" />
							
							</tr>
						</thead>
						<tbody>
						<g:each in="${QCHeaderInstanceList}" status="i" var="QCHeaderInstance">
							<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
							
								<td><g:link action="show" id="${QCHeaderInstance.id}">${fieldValue(bean: QCHeaderInstance, field: "updatedBy")}</g:link></td>
							
								<td>${fieldValue(bean: QCHeaderInstance, field: "createdBy")}</td>
							
								<td><g:formatDate date="${QCHeaderInstance.date}" /></td>
							
								<td><g:formatDate date="${QCHeaderInstance.dateCreated}" /></td>
							
								<td>${fieldValue(bean: QCHeaderInstance, field: "gallon")}</td>
							
								<td><g:formatDate date="${QCHeaderInstance.lastUpdated}" /></td>
							
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
