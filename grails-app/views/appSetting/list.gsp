
<%@ page import="com.smanggin.trackingmanagement.AppSetting" %>
<!doctype html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'appSetting.label', default: 'AppSetting')}" />
	<title><g:message code="default.list.label" args="[entityName]" /></title>
</head>

<body>
	
<section id="list-appSetting" class="first">
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
							
								<g:sortableColumn property="code" title="${message(code: 'appSetting.code.label', default: 'Code')}" />
							
								<g:sortableColumn property="dateCreated" title="${message(code: 'appSetting.dateCreated.label', default: 'Date Created')}" />
							
								<g:sortableColumn property="lastUpdated" title="${message(code: 'appSetting.lastUpdated.label', default: 'Last Updated')}" />
							
								<g:sortableColumn property="unit" title="${message(code: 'appSetting.unit.label', default: 'Unit')}" />
							
								<g:sortableColumn property="val" title="${message(code: 'appSetting.val.label', default: 'Val')}" />
							
							</tr>
						</thead>
						<tbody>
						<g:each in="${appSettingInstanceList}" status="i" var="appSettingInstance">
							<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
							
								<td><g:link action="show" id="${appSettingInstance.id}">${fieldValue(bean: appSettingInstance, field: "code")}</g:link></td>
							
								<td><g:formatDate date="${appSettingInstance.dateCreated}" /></td>
							
								<td><g:formatDate date="${appSettingInstance.lastUpdated}" /></td>
							
								<td>${fieldValue(bean: appSettingInstance, field: "unit")}</td>
							
								<td>${fieldValue(bean: appSettingInstance, field: "val")}</td>
							
							</tr>
						</g:each>
						</tbody>
					</table>
				</div><!--/.box-body table-responsive -->

				<div class="box-footer clearfix">
					<bs:paginate total="${appSettingInstanceTotal}" />
				</div><!--/.box-footer clearfix -->
			</div><!--/.box box-primary -->	
		</div><!--/.col-lg-12 -->	
	</div><!--/.row -->			

</section>

</body>

</html>
