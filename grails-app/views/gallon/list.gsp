
<%@ page import="com.smanggin.trackingmanagement.Gallon" %>
<!doctype html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'gallon.label', default:session.trackedItem)}" />
	<title><g:message code="default.list.label" args="[entityName]" /></title>
</head>

<body>
	
<section id="list-gallon" class="first">
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
							
								<g:sortableColumn property="code" title="${message(code: 'gallon.code.label', default: 'Code')}" />
							
								<g:sortableColumn property="writeOff" title="${message(code: 'gallon.writeOff.label', default: 'Write Off')}" />
							
								<g:sortableColumn property="updatedBy" title="${message(code: 'gallon.updatedBy.label', default: 'Updated By')}" />
							
								<g:sortableColumn property="createdBy" title="${message(code: 'gallon.createdBy.label', default: 'Created By')}" />
							
								<g:sortableColumn property="dateCreated" title="${message(code: 'gallon.dateCreated.label', default: 'Date Created')}" />
							
								<g:sortableColumn property="lastUpdated" title="${message(code: 'gallon.lastUpdated.label', default: 'Last Updated')}" />
							
							</tr>
						</thead>
						<tbody>
						<g:each in="${gallonInstanceList}" status="i" var="gallonInstance">
							<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
							
								<td><g:link action="show" id="${gallonInstance.serverId}">${fieldValue(bean: gallonInstance, field: "code")}</g:link></td>
							
								<td><g:formatBoolean boolean="${gallonInstance.writeOff}" /></td>
							
								<td>${fieldValue(bean: gallonInstance, field: "updatedBy")}</td>
							
								<td>${fieldValue(bean: gallonInstance, field: "createdBy")}</td>
							
								<td><g:formatDate date="${gallonInstance.dateCreated}" /></td>
							
								<td><g:formatDate date="${gallonInstance.lastUpdated}" /></td>
							
							</tr>
						</g:each>
						</tbody>
					</table>
				</div><!--/.box-body table-responsive -->

				<div class="box-footer clearfix">
					<bs:paginate total="${gallonInstanceTotal}" />
				</div><!--/.box-footer clearfix -->
			</div><!--/.box box-primary -->	
		</div><!--/.col-lg-12 -->	
	</div><!--/.row -->			

</section>

</body>

</html>
