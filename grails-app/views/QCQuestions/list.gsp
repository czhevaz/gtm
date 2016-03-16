
<%@ page import="com.smanggin.trackingmanagement.QCQuestions" %>
<!doctype html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'QCQuestions.label', default: 'QCQuestions')}" />
	<title><g:message code="default.list.label" args="[entityName]" /></title>
</head>

<body>
	
<section id="list-QCQuestions" class="first">
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
							
								<g:sortableColumn property="sequenceNo" title="${message(code: 'QCQuestions.sequenceNo.label', default: 'Sequence No')}" />
							
								<g:sortableColumn property="parameterDesc" title="${message(code: 'QCQuestions.parameterDesc.label', default: 'Parameter Desc')}" />
							
								<g:sortableColumn property="notes" title="${message(code: 'QCQuestions.notes.label', default: 'Notes')}" />
							
								<g:sortableColumn property="updatedBy" title="${message(code: 'QCQuestions.updatedBy.label', default: 'Updated By')}" />
							
								<g:sortableColumn property="createdBy" title="${message(code: 'QCQuestions.createdBy.label', default: 'Created By')}" />
							
								<g:sortableColumn property="dateCreated" title="${message(code: 'QCQuestions.dateCreated.label', default: 'Date Created')}" />
							
							</tr>
						</thead>
						<tbody>
						<g:each in="${QCQuestionsInstanceList}" status="i" var="QCQuestionsInstance">
							<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
							
								<td>${fieldValue(bean: QCQuestionsInstance, field: "sequenceNo")}</td>
							
								<td><g:link action="show" params="[serverId:QCQuestionsInstance?.serverId]">${fieldValue(bean: QCQuestionsInstance, field: "parameterDesc")}</g:link></td>
							
								<td>${fieldValue(bean: QCQuestionsInstance, field: "notes")}</td>
							
								<td>${fieldValue(bean: QCQuestionsInstance, field: "updatedBy")}</td>
							
								<td>${fieldValue(bean: QCQuestionsInstance, field: "createdBy")}</td>
							
								<td><g:formatDate date="${QCQuestionsInstance.dateCreated}" /></td>
							
							</tr>
						</g:each>
						</tbody>
					</table>
				</div><!--/.box-body table-responsive -->

				<div class="box-footer clearfix">
					<bs:paginate total="${QCQuestionsInstanceTotal}" />
				</div><!--/.box-footer clearfix -->
			</div><!--/.box box-primary -->	
		</div><!--/.col-lg-12 -->	
	</div><!--/.row -->			

</section>

</body>

</html>
