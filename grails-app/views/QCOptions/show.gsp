
<%@ page import="com.smanggin.trackingmanagement.QCOptions" %>
<!doctype html>
<html>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'QCOptions.label', default: 'QCOptions')}" />
	<title><g:message code="default.show.label" args="[entityName]" /></title>
</head>

<body>

<section id="show-QCOptions" class="first">
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
								<td valign="top" class="name"><g:message code="QCOptions.description.label" default="Description" /></td>
								
								<td valign="top" class="value">${fieldValue(bean: QCOptionsInstance, field: "description")}</td>
								
							</tr>

							<tr class="prop">
								<td valign="top" class="name"><g:message code="QCOptions.qCQuestions.label" default="QC Questions" /></td>
								
								<td valign="top" class="value"><g:link controller="QCQuestions" action="show" id="${QCOptionsInstance?.qCQuestions?.id}">${QCOptionsInstance?.qCQuestions?.encodeAsHTML()}</g:link></td>
								
							</tr>
						
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="QCOptions.updatedBy.label" default="Updated By" /></td>
								
								<td valign="top" class="value">${fieldValue(bean: QCOptionsInstance, field: "updatedBy")}</td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="QCOptions.createdBy.label" default="Created By" /></td>
								
								<td valign="top" class="value">${fieldValue(bean: QCOptionsInstance, field: "createdBy")}</td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="QCOptions.dateCreated.label" default="Date Created" /></td>
								
								<td valign="top" class="value"><g:formatDate date="${QCOptionsInstance?.dateCreated}" /></td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="QCOptions.lastUpdated.label" default="Last Updated" /></td>
								
								<td valign="top" class="value"><g:formatDate date="${QCOptionsInstance?.lastUpdated}" /></td>
								
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
