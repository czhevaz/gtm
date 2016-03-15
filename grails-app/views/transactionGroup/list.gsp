
<%@ page import="com.smanggin.trackingmanagement.TransactionGroup" %>
<!doctype html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'transactionGroup.label', default: 'TransactionGroup')}" />
	<title><g:message code="default.list.label" args="[entityName]" /></title>
</head>

<body>
	
<section id="list-transactionGroup" class="first">
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
							
								<g:sortableColumn property="updatedBy" title="${message(code: 'transactionGroup.updatedBy.label', default: 'Updated By')}" />
							
								<g:sortableColumn property="createdBy" title="${message(code: 'transactionGroup.createdBy.label', default: 'Created By')}" />
							
								<g:sortableColumn property="dateCreated" title="${message(code: 'transactionGroup.dateCreated.label', default: 'Date Created')}" />
							
								<g:sortableColumn property="lastUpdated" title="${message(code: 'transactionGroup.lastUpdated.label', default: 'Last Updated')}" />
							
								<g:sortableColumn property="name" title="${message(code: 'transactionGroup.name.label', default: 'Name')}" />
							
								<g:sortableColumn property="numberingMethod" title="${message(code: 'transactionGroup.numberingMethod.label', default: 'Numbering Method')}" />
							
							</tr>
						</thead>
						<tbody>
						<g:each in="${transactionGroupInstanceList}" status="i" var="transactionGroupInstance">
							<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
							
								<td><g:link action="show" id="${transactionGroupInstance.id}">${fieldValue(bean: transactionGroupInstance, field: "updatedBy")}</g:link></td>
							
								<td>${fieldValue(bean: transactionGroupInstance, field: "createdBy")}</td>
							
								<td><g:formatDate date="${transactionGroupInstance.dateCreated}" /></td>
							
								<td><g:formatDate date="${transactionGroupInstance.lastUpdated}" /></td>
							
								<td>${fieldValue(bean: transactionGroupInstance, field: "name")}</td>
							
								<td>${fieldValue(bean: transactionGroupInstance, field: "numberingMethod")}</td>
							
							</tr>
						</g:each>
						</tbody>
					</table>
				</div><!--/.box-body table-responsive -->

				<div class="box-footer clearfix">
					<bs:paginate total="${transactionGroupInstanceTotal}" />
				</div><!--/.box-footer clearfix -->
			</div><!--/.box box-primary -->	
		</div><!--/.col-lg-12 -->	
	</div><!--/.row -->			

</section>

</body>

</html>
