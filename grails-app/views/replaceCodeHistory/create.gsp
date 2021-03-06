<%@ page import="com.smanggin.trackingmanagement.ReplaceCodeHistory" %>
<!doctype html>
<html>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'replaceCodeHistory.label', default: 'ReplaceCodeHistory')}" />
	<title><g:message code="default.create.label" args="[entityName]" /></title>
</head>

<body>

<section id="create-replaceCodeHistory" class="first">
	<div class="row">
		<div class="col-lg-12">
			<div class="box box-primary">
				<div class="box-header with-border">
    				<h3 class="box-title"><g:message code="default.create.label" args="[entityName]" /></h3>
    			</div><!--/.box-header with-border -->	
				<g:hasErrors bean="${replaceCodeHistoryInstance}">
				<div class="alert alert-error">
					<g:renderErrors bean="${replaceCodeHistoryInstance}" as="list" />
				</div>
				</g:hasErrors>
				
				<g:form class="form-horizontal" >
					<g:hiddenField name="createdBy" value="${session.user}" />
					<div class="box-body">
						<fieldset class="form">
							<g:render template="form"/>
						</fieldset>
					</div><!--/.box-body -->
					<div class="box-footer">
						
					</div><!--/.box-footer -->	
				</g:form>
				<g:render template="detail"/> 
			</div><!--/.box box-primary -->	
		</div><!--/.col-lg-12 -->	
	</div><!--/.row -->	

	<g:render template="modalReplaceCode"/> 		
</section>
		
</body>

</html>
