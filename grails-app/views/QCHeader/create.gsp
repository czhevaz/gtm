<%@ page import="com.smanggin.trackingmanagement.QCHeader" %>
<!doctype html>
<html>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'QCHeader.label', default: 'QCHeader')}" />
	<title><g:message code="default.create.label" args="[entityName]" /></title>
</head>

<body>

<section id="create-QCHeader" class="first">
	<div class="row">
		<div class="col-lg-12">
			<div class="box box-primary">
				<div class="box-header with-border">
    				<h3 class="box-title">${entityName}</h3>
    			</div><!--/.box-header with-border -->	
				<g:hasErrors bean="${QCHeaderInstance}">
				<div class="alert alert-error">
					<g:renderErrors bean="${QCHeaderInstance}" as="list" />
				</div>
				</g:hasErrors>
				
				<g:form action="save" class="form-horizontal" >
					<div class="box-body">
						<fieldset class="form">
							<g:render template="form"/>
						</fieldset>
					</div><!--/.box-body -->
					<div class="box-footer">
						<div class="form-actions">
							<g:submitButton id="createQC" name="create" class="btn btn-primary disabled" value="${message(code: 'default.button.create.label', default: 'Create')}" />
				            <button class="btn" type="reset"><g:message code="default.button.reset.label" default="Reset" /></button>
						</div>
					</div><!--/.box-footer -->	
				</g:form>
			</div><!--/.box box-primary -->	
		</div><!--/.col-lg-12 -->	
	</div><!--/.row -->			
	<r:script>
	$('#gallon').focus();

</r:script>

</section>
		
</body>

</html>
