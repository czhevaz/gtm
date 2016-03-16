<%@ page import="com.smanggin.trackingmanagement.QCHeader" %>
<%@ page import="com.smanggin.trackingmanagement.GlobalService" %>
<%
    def myService = grailsApplication.classLoader.loadClass('com.smanggin.trackingmanagement.GlobalService').newInstance()
%>

<!doctype html>
<html>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'QCHeader.label', default: 'QCHeader')}" />
	<title><g:message code="default.edit.label" args="[entityName]" /></title>
</head>

<body>

<section id="edit-QCHeader" class="first">
	<g:form method="post" class="form-horizontal" >
	<div class="row">
		<div class="col-lg-12">
			<div class="box box-primary">
				<div class="box-header with-border">
                  <h3 class="box-title"><g:message code="default.edit.label" args="[entityName]" /></h3>
                </div><!--/.box-header with-border -->	

				<g:hasErrors bean="${QCHeaderInstance}">
				<div class="alert alert-error">
					<g:renderErrors bean="${QCHeaderInstance}" as="list" />
				</div>
				</g:hasErrors>

				
					<div class="box-body">
						<g:hiddenField name="serverId" value="${QCHeaderInstance?.serverId}" />
						<g:hiddenField name="version" value="${QCHeaderInstance?.version}" />
						
						<fieldset class="form">
							<g:render template="form"/>
						</fieldset>
					</div><!--/.box-body -->	

					<div class="box-footer">
						<div class="form-actions">
							<g:actionSubmit class="btn btn-primary" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" />
							<g:actionSubmit class="btn btn-danger" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				            <button class="btn" type="reset"><g:message code="default.button.reset.label" default="Reset" /></button>
						</div>
					</div><!--/.box-footer -->	
				
				
			</div><!--/.box box-primary -->	
		</div><!--/.col-lg-12 -->	
	</div><!--/.row -->			
	<div class="row">
		<div class="col-lg-12">
			<div class="box box-primary">
				<div class="box-header with-border">
                  <h3 class="box-title">Question</h3>
                </div><!--/.box-header with-border -->	
				
					<div class="box-body">
						<g:each in="${processQCAll}" status="i" var="processQCInstance">
							<g:if test="${processQCInstance?.qcMaster?.qCQuestions?.size() > 0}">
							<table class="table table-bordered margin-top-medium">
								<thead>
									<tr>
										<td>${processQCInstance?.qcMaster?.name}</td>
									</tr>
								</thead>
								<tbody>

									<g:each in="${processQCInstance?.qcMaster?.qCQuestions.sort{it.sequenceNo}}" status="j" var="qcQuestionsInstance">
										<tr>
											<td>${j+1}. ${qcQuestionsInstance?.parameterDesc}</td>
										</tr>
										<tr>
											<td>  <g:textArea class="form-control" name="${processQCInstance?.qcMaster?.code}_${qcQuestionsInstance?.sequenceNo}" value="${myService?.valueQCDetail(QCHeaderInstance,qcQuestionsInstance?.qCMaster,qcQuestionsInstance)}" rows="5" cols="40"/></td>
										</tr>
									</g:each>	
								</tbody>
							</table>
							</g:if>
						</g:each>			
					</div><!--/.box-body -->	
			</div><!--/.box box-primary -->	
		</div><!--/.col-lg-12 -->	
	</div><!--/.row -->
	</g:form>
</section>
			
</body>

</html>
