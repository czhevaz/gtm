
<%@ page import="com.smanggin.trackingmanagement.ProcessQC" %>
<!doctype html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'processQC.label', default: 'ProcessQC')}" />
	<title><g:message code="default.list.label" args="[entityName]" /></title>
</head>

<body>
	
<section id="list-processQC" class="first">
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
							
								<g:sortableColumn property="sequenceNo" title="${message(code: 'processQC.sequenceNo.label', default: 'Sequence No')}" />
							
								<g:sortableColumn property="date1" title="${message(code: 'processQC.date1.label', default: 'Date1')}" />
							
								<g:sortableColumn property="date2" title="${message(code: 'processQC.date2.label', default: 'Date2')}" />
							
								<g:sortableColumn property="updatedBy" title="${message(code: 'processQC.updatedBy.label', default: 'Updated By')}" />
							
								<g:sortableColumn property="createdBy" title="${message(code: 'processQC.createdBy.label', default: 'Created By')}" />
							
								<g:sortableColumn property="dateCreated" title="${message(code: 'processQC.dateCreated.label', default: 'Date Created')}" />
							
							</tr>
						</thead>
						<tbody>
						<g:each in="${processQCInstanceList}" status="i" var="processQCInstance">
							<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
							
								<td><g:link action="show" id="${processQCInstance.id}">${fieldValue(bean: processQCInstance, field: "sequenceNo")}</g:link></td>
							
								<td><g:formatDate date="${processQCInstance.date1}" /></td>
							
								<td><g:formatDate date="${processQCInstance.date2}" /></td>
							
								<td>${fieldValue(bean: processQCInstance, field: "updatedBy")}</td>
							
								<td>${fieldValue(bean: processQCInstance, field: "createdBy")}</td>
							
								<td><g:formatDate date="${processQCInstance.dateCreated}" /></td>
							
							</tr>
						</g:each>
						</tbody>
					</table>
				</div><!--/.box-body table-responsive -->

				<div class="box-footer clearfix">
					<bs:paginate total="${processQCInstanceTotal}" />
				</div><!--/.box-footer clearfix -->
			</div><!--/.box box-primary -->	
		</div><!--/.col-lg-12 -->	
	</div><!--/.row -->			

</section>

</body>

</html>
