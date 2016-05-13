
<%@ page import="com.smanggin.trackingmanagement.Item" %>
<!doctype html>
<html>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'item.label', default: 'Item')}" />
	<title><g:message code="default.show.label" args="[entityName]" /></title>
</head>

<body>

<section id="show-item" class="first">
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
								<td valign="top" class="name"><g:message code="item.name.label" default="Name" /></td>
								
								<td valign="top" class="value">${fieldValue(bean: itemInstance, field: "name")}</td>
								
							</tr>

							<tr class="prop">
								<td valign="top" class="name"><g:message code="item.description.label" default="Description" /></td>
								
								<td valign="top" class="value">${fieldValue(bean: itemInstance, field: "description")}</td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="item.lastUpdated.label" default="Last Updated" /></td>
								
								<td valign="top" class="value"><g:formatDate date="${itemInstance?.lastUpdated}" /></td>
								
							</tr>
							
							<tr class="prop">
								<td valign="top" class="name"><g:message code="item.dateCreated.label" default="Date Created" /></td>
								
								<td valign="top" class="value"><g:formatDate date="${itemInstance?.dateCreated}" /></td>
								
							</tr>
						
						</tbody>
					</table>
				</div><!--/.row -->
				<div class="box-footer clearfix">
						
				</div><!--/.box-footer clearfix -->
			</div><!--/.box-body table-responsive -->

			
		</div><!--/.box box-primary -->
	</div><!--/.row -->
</section>

</body>

</html>
