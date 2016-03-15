
<%@ page import="com.smanggin.trackingmanagement.QCHeader" %>
<!doctype html>
<html>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'QCHeader.label', default: 'QCHeader')}" />
	<title><g:message code="default.show.label" args="[entityName]" /></title>
</head>

<body>

<section id="show-QCHeader" class="first">
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
								<td valign="top" class="name"><g:message code="QCHeader.updatedBy.label" default="Updated By" /></td>
								
								<td valign="top" class="value">${fieldValue(bean: QCHeaderInstance, field: "updatedBy")}</td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="QCHeader.createdBy.label" default="Created By" /></td>
								
								<td valign="top" class="value">${fieldValue(bean: QCHeaderInstance, field: "createdBy")}</td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="QCHeader.date.label" default="Date" /></td>
								
								<td valign="top" class="value"><g:formatDate date="${QCHeaderInstance?.date}" /></td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="QCHeader.dateCreated.label" default="Date Created" /></td>
								
								<td valign="top" class="value"><g:formatDate date="${QCHeaderInstance?.dateCreated}" /></td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="QCHeader.gallon.label" default="Gallon" /></td>
								
								<td valign="top" class="value"><g:link controller="gallon" action="show" id="${QCHeaderInstance?.gallon?.id}">${QCHeaderInstance?.gallon?.encodeAsHTML()}</g:link></td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="QCHeader.lastUpdated.label" default="Last Updated" /></td>
								
								<td valign="top" class="value"><g:formatDate date="${QCHeaderInstance?.lastUpdated}" /></td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="QCHeader.number.label" default="Number" /></td>
								
								<td valign="top" class="value">${fieldValue(bean: QCHeaderInstance, field: "number")}</td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="QCHeader.plant.label" default="Plant" /></td>
								
								<td valign="top" class="value"><g:link controller="plant" action="show" id="${QCHeaderInstance?.plant?.id}">${QCHeaderInstance?.plant?.encodeAsHTML()}</g:link></td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="QCHeader.qCDetails.label" default="QCD etails" /></td>
								
								<td valign="top" style="text-align: left;" class="value">
									<ul>
									<g:each in="${QCHeaderInstance.qCDetails}" var="q">
										<li><g:link controller="QCDetail" action="show" id="${q.id}">${q?.encodeAsHTML()}</g:link></li>
									</g:each>
									</ul>
								</td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="QCHeader.qcActions.label" default="Qc Actions" /></td>
								
								<td valign="top" class="value"><g:link controller="QCActions" action="show" id="${QCHeaderInstance?.qcActions?.id}">${QCHeaderInstance?.qcActions?.encodeAsHTML()}</g:link></td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="QCHeader.serverId.label" default="Server Id" /></td>
								
								<td valign="top" class="value">${fieldValue(bean: QCHeaderInstance, field: "serverId")}</td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="QCHeader.transactionGroup.label" default="Transaction Group" /></td>
								
								<td valign="top" class="value"><g:link controller="transactionGroup" action="show" id="${QCHeaderInstance?.transactionGroup?.id}">${QCHeaderInstance?.transactionGroup?.encodeAsHTML()}</g:link></td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="QCHeader.workCenter.label" default="Work Center" /></td>
								
								<td valign="top" class="value"><g:link controller="workCenter" action="show" id="${QCHeaderInstance?.workCenter?.id}">${QCHeaderInstance?.workCenter?.encodeAsHTML()}</g:link></td>
								
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
