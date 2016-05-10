
<%@ page import="com.smanggin.trackingmanagement.QCMaster" %>
<!doctype html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'QCMaster.label', default: 'QCMaster')}" />
	<title><g:message code="default.list.label" args="[entityName]" /></title>
</head>

<body>
	
<section id="list-QCMaster" class="first">
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
								<td>No.</td>							
								
								<g:sortableColumn property="code" title="${message(code: 'QCMaster.code.label', default: 'Code')}" />
							
								<g:sortableColumn property="name" title="${message(code: 'QCMaster.name.label', default: 'Name')}" />
							
								<th><g:message code="QCMaster.user.label" default="User" /></th>
							
								<g:sortableColumn property="updatedBy" title="${message(code: 'QCMaster.updatedBy.label', default: 'Updated By')}" />
							
								<g:sortableColumn property="active" title="${message(code: 'QCMaster.active.label', default: 'Active')}" />
							
							</tr>
						</thead>
						<tbody>
						<g:each in="${QCMasterInstanceList}" status="i" var="QCMasterInstance">
							<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
								
								<td>${i+1}</td>

								<td><g:link action="show" params="[serverId:QCMasterInstance.serverId]">${fieldValue(bean: QCMasterInstance, field: "code")}</g:link></td>
							
								<td>${fieldValue(bean: QCMasterInstance, field: "name")}</td>
							
								<td>${fieldValue(bean: QCMasterInstance, field: "user")}</td>
							
								<td>${fieldValue(bean: QCMasterInstance, field: "updatedBy")}</td>
							
								<td><g:formatBoolean boolean="${QCMasterInstance.active}" /></td>
							
							</tr>
						</g:each>
						</tbody>
					</table>
				</div><!--/.box-body table-responsive -->

				<div class="box-footer clearfix">
					<bs:paginate total="${QCMasterInstanceTotal}" />
				</div><!--/.box-footer clearfix -->
			</div><!--/.box box-primary -->	
		</div><!--/.col-lg-12 -->	
	</div><!--/.row -->			

</section>

</body>

</html>
