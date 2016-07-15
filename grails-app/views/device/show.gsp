
<%@ page import="com.smanggin.trackingmanagement.Device" %>
<!doctype html>
<html>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'device.label', default: 'Device')}" />
	<title><g:message code="default.show.label" args="[entityName]" /></title>
</head>

<body>

<section id="show-device" class="first">
	<div class="row">
		<div class="col-lg-12">
			<div class="box box-primary">
				<div class="box-header with-border">
                  <h3 class="box-title"><g:message code="default.show.label" args="[entityName]" /></h3>
                </div><!--/.box-header with-border -->	
                <div class="box-body table-responsive">
					<table class="table table-striped">
						<tbody>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="device.ipAddress.label" default="Ip Address" /></td>
								
								<td valign="top" class="value">${fieldValue(bean: deviceInstance, field: "ipAddress")}</td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="device.line.label" default="Line" /></td>
								
								<td valign="top" class="value"><g:link controller="line" action="show" id="${deviceInstance?.line?.id}">${deviceInstance?.line?.encodeAsHTML()}</g:link></td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="device.plant.label" default="Plant" /></td>
								
								<td valign="top" class="value"><g:link controller="plant" action="show" id="${deviceInstance?.plant?.id}">${deviceInstance?.plant?.encodeAsHTML()}</g:link></td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="device.serverId.label" default="Server Id" /></td>
								
								<td valign="top" class="value">${fieldValue(bean: deviceInstance, field: "serverId")}</td>
								
							</tr>
						
						</tbody>
					</table>
				</div><!--/.row -->
				<div class="box-footer clearfix">
						
				</div><!--/.box-footer clearfix -->
			</div><!--/.box-body table-responsive -->

			<g:render template="detail"/> 
		</div><!--/.box box-primary -->
	</div><!--/.row -->
</section>

</body>

</html>
