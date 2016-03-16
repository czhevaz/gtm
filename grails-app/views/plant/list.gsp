
<%@ page import="com.smanggin.trackingmanagement.Plant" %>
<!doctype html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'plant.label', default: 'Plant')}" />
	<title><g:message code="default.list.label" args="[entityName]" /></title>
</head>

<body>
	
<section id="list-plant" class="first">
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
							
								<g:sortableColumn property="code" title="${message(code: 'plant.code.label', default: 'Code')}" />
							
								<g:sortableColumn property="name" title="${message(code: 'plant.name.label', default: 'Name')}" />
							
								<g:sortableColumn property="address" title="${message(code: 'plant.address.label', default: 'Address')}" />
							
								<g:sortableColumn property="city" title="${message(code: 'plant.city.label', default: 'City')}" />
							
								<g:sortableColumn property="postalCode" title="${message(code: 'plant.postalCode.label', default: 'Postal Code')}" />
							
								<g:sortableColumn property="country" title="${message(code: 'plant.country.label', default: 'Country')}" />
							
							</tr>
						</thead>
						<tbody>
						<g:each in="${plantInstanceList}" status="i" var="plantInstance">
							<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
							
								<td><g:link action="show" params="[serverId:plantInstance?.serverId]">${fieldValue(bean: plantInstance, field: "code")}</g:link></td>
							
								<td>${fieldValue(bean: plantInstance, field: "name")}</td>
							
								<td>${fieldValue(bean: plantInstance, field: "address")}</td>
							
								<td>${fieldValue(bean: plantInstance, field: "city")}</td>
							
								<td>${fieldValue(bean: plantInstance, field: "postalCode")}</td>
							
								<td>${fieldValue(bean: plantInstance, field: "country")}</td>
							
							</tr>
						</g:each>
						</tbody>
					</table>
				</div><!--/.box-body table-responsive -->

				<div class="box-footer clearfix">
					<bs:paginate total="${plantInstanceTotal}" />
				</div><!--/.box-footer clearfix -->
			</div><!--/.box box-primary -->	
		</div><!--/.col-lg-12 -->	
	</div><!--/.row -->			

</section>

</body>

</html>
