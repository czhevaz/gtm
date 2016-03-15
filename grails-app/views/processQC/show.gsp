
<%@ page import="com.smanggin.trackingmanagement.ProcessQC" %>
<!doctype html>
<html>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'processQC.label', default: 'ProcessQC')}" />
	<title><g:message code="default.show.label" args="[entityName]" /></title>
</head>

<body>

<section id="show-processQC" class="first">
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
								<td valign="top" class="name"><g:message code="processQC.sequenceNo.label" default="Sequence No" /></td>
								
								<td valign="top" class="value">${fieldValue(bean: processQCInstance, field: "sequenceNo")}</td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="processQC.date1.label" default="Date1" /></td>
								
								<td valign="top" class="value"><g:formatDate date="${processQCInstance?.date1}" /></td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="processQC.date2.label" default="Date2" /></td>
								
								<td valign="top" class="value"><g:formatDate date="${processQCInstance?.date2}" /></td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="processQC.updatedBy.label" default="Updated By" /></td>
								
								<td valign="top" class="value">${fieldValue(bean: processQCInstance, field: "updatedBy")}</td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="processQC.createdBy.label" default="Created By" /></td>
								
								<td valign="top" class="value">${fieldValue(bean: processQCInstance, field: "createdBy")}</td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="processQC.dateCreated.label" default="Date Created" /></td>
								
								<td valign="top" class="value"><g:formatDate date="${processQCInstance?.dateCreated}" /></td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="processQC.lastUpdated.label" default="Last Updated" /></td>
								
								<td valign="top" class="value"><g:formatDate date="${processQCInstance?.lastUpdated}" /></td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="processQC.process.label" default="Process" /></td>
								
								<td valign="top" class="value"><g:link controller="process" action="show" id="${processQCInstance?.process?.id}">${processQCInstance?.process?.encodeAsHTML()}</g:link></td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="processQC.qcMaster.label" default="Qc Master" /></td>
								
								<td valign="top" class="value"><g:link controller="QCMaster" action="show" id="${processQCInstance?.qcMaster?.id}">${processQCInstance?.qcMaster?.encodeAsHTML()}</g:link></td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="processQC.serverId.label" default="Server Id" /></td>
								
								<td valign="top" class="value">${fieldValue(bean: processQCInstance, field: "serverId")}</td>
								
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
