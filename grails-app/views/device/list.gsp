
<%@ page import="com.smanggin.trackingmanagement.Device" %>
<!doctype html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'device.label', default: 'Device')}" />
	<title><g:message code="default.list.label" args="[entityName]" /></title>
</head>

<body>
	
<section id="list-device" class="first">
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
							
								<g:sortableColumn property="ipAddress" title="${message(code: 'device.ipAddress.label', default: 'Ip Address')}" />
							
								<th><g:message code="device.line.label" default="Line" /></th>
							
								<th><g:message code="device.plant.label" default="Plant" /></th>

								<th><g:message code="device.itemTeacked.label" default="itemTracked" /></th>
							
								
							</tr>
						</thead>
						<tbody>
						<g:each in="${deviceInstanceList}" status="i" var="deviceInstance">
							<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
							
								<td><g:link action="show" id="${deviceInstance.id}">${fieldValue(bean: deviceInstance, field: "ipAddress")}</g:link></td>
							
								<td>${fieldValue(bean: deviceInstance, field: "line")}</td>
							
								<td>${fieldValue(bean: deviceInstance, field: "plant")}</td>
							
								<td>${fieldValue(bean: deviceInstance, field: "item")}</td>
							
							</tr>
						</g:each>
						</tbody>
					</table>
				</div><!--/.box-body table-responsive -->

				<div class="box-footer clearfix">
					<bs:paginate total="${deviceInstanceTotal}" />
				</div><!--/.box-footer clearfix -->
			</div><!--/.box box-primary -->	
		</div><!--/.col-lg-12 -->	
	</div><!--/.row -->			

</section>

</body>

</html>
