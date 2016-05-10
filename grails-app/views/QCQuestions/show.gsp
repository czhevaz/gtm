
<%@ page import="com.smanggin.trackingmanagement.QCQuestions" %>
<!doctype html>
<html>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'QCQuestions.label', default: 'QCQuestions')}" />
	<title><g:message code="default.show.label" args="[entityName]" /></title>
</head>

<body>

<section id="show-QCQuestions" class="first">
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
								<td valign="top" class="name"><g:message code="QCQuestions.sequenceNo.label" default="Sequence No" /></td>
								
								<td valign="top" class="value">${fieldValue(bean: QCQuestionsInstance, field: "sequenceNo")}</td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="QCQuestions.parameterDesc.label" default="Parameter Desc" /></td>
								
								<td valign="top" class="value">${fieldValue(bean: QCQuestionsInstance, field: "parameterDesc")}</td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="QCQuestions.notes.label" default="Notes" /></td>
								
								<td valign="top" class="value">${fieldValue(bean: QCQuestionsInstance, field: "notes")}</td>
								
							</tr>

							<tr class="prop">
								<td valign="top" class="name"><g:message code="QCQuestions.parameterType.label" default="Parameter Type" /></td>
								
								<td valign="top" class="value">${fieldValue(bean: QCQuestionsInstance, field: "parameterType")}</td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="QCQuestions.createdBy.label" default="Created By" /></td>
								
								<td valign="top" class="value">${fieldValue(bean: QCQuestionsInstance, field: "createdBy")}</td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="QCQuestions.dateCreated.label" default="Date Created" /></td>
								
								<td valign="top" class="value"><g:formatDate date="${QCQuestionsInstance?.dateCreated}" /></td>
								
							</tr>

								<tr class="prop">
								<td valign="top" class="name"><g:message code="QCQuestions.updatedBy.label" default="Updated By" /></td>
								
								<td valign="top" class="value">${fieldValue(bean: QCQuestionsInstance, field: "updatedBy")}</td>
								
							</tr>
						
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="QCQuestions.lastUpdated.label" default="Last Updated" /></td>
								
								<td valign="top" class="value"><g:formatDate date="${QCQuestionsInstance?.lastUpdated}" /></td>
								
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
