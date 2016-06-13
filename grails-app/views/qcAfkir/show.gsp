
<%@ page import="com.smanggin.trackingmanagement.QcAfkir" %>
<!doctype html>
<html>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta name="layout" content="kickstart" />
	<g:set var="entityName" value="${message(code: 'qcAfkir.label', default: 'QcAfkir')}" />
	<title><g:message code="default.show.label" args="[entityName]" /></title>
</head>

<body>

<section id="show-qcAfkir" class="first">
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
								<td valign="top" class="name"><g:message code="qcAfkir.number.label" default="Number" /></td>
								
								<td valign="top" class="value">${fieldValue(bean: qcAfkirInstance, field: "number")}</td>
								
							</tr>
							<tr class="prop">
								<td valign="top" class="name"><g:message code="qcAfkir.transactionGroup.label" default="Transaction Group" /></td>
								
								<td valign="top" class="value"><g:link controller="transactionGroup" action="show" id="${qcAfkirInstance?.transactionGroup?.id}">${qcAfkirInstance?.transactionGroup?.encodeAsHTML()}</g:link></td>
								
							</tr>
						
							
							<tr class="prop">
								<td valign="top" class="name"><g:message code="qcAfkir.plant.label" default="Plant" /></td>
								
								<td valign="top" class="value"><g:link controller="plant" action="show" id="${qcAfkirInstance?.plant?.id}">${qcAfkirInstance?.plant?.encodeAsHTML()}</g:link></td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="qcAfkir.workCenter.label" default="Work Center" /></td>
								
								<td valign="top" class="value"><g:link controller="workCenter" action="show" id="${qcAfkirInstance?.workCenter?.id}">${qcAfkirInstance?.workCenter?.encodeAsHTML()}</g:link></td>
								
							</tr>
							

							<tr class="prop">
								<td valign="top" class="name"><g:message code="qcAfkir.shift.label" default="Shift" /></td>
								
								<td valign="top" class="value"><g:link controller="shift" action="show" id="${qcAfkirInstance?.shift?.id}">${qcAfkirInstance?.shift?.encodeAsHTML()}</g:link></td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="qcAfkir.item.label" default="Item" /></td>
								
								<td valign="top" class="value"><g:link controller="item" action="show" id="${qcAfkirInstance?.item?.id}">${qcAfkirInstance?.item?.encodeAsHTML()}</g:link></td>
								
							</tr>
						
							
							<tr class="prop">
								<td valign="top" class="name"><g:message code="qcAfkir.description.label" default="Description" /></td>
								
								<td valign="top" class="value">${fieldValue(bean: qcAfkirInstance, field: "description")}</td>
								
							</tr>

							<tr class="prop">
								<td valign="top" class="name"><g:message code="qcAfkir.qCQuestions.label" default="QC Questions" /></td>
								
								<td valign="top" class="value"><g:link controller="QCQuestions" action="show" id="${qcAfkirInstance?.qCQuestions?.id}">${qcAfkirInstance?.qCQuestions?.encodeAsHTML()}</g:link></td>
								
							</tr>
						
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="qcAfkir.createdBy.label" default="Created By" /></td>
								
								<td valign="top" class="value">${fieldValue(bean: qcAfkirInstance, field: "createdBy")}</td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="qcAfkir.date.label" default="Date" /></td>
								
								<td valign="top" class="value"><g:formatDate date="${qcAfkirInstance?.date}" /></td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="qcAfkir.dateCreated.label" default="Date Created" /></td>
								
								<td valign="top" class="value"><g:formatDate date="${qcAfkirInstance?.dateCreated}" /></td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="qcAfkir.lastUpdated.label" default="Last Updated" /></td>
								
								<td valign="top" class="value"><g:formatDate date="${qcAfkirInstance?.lastUpdated}" /></td>
								
							</tr>
						
							
							
							<tr class="prop">
								<td valign="top" class="name"><g:message code="qcAfkir.updatedBy.label" default="Updated By" /></td>
								
								<td valign="top" class="value">${fieldValue(bean: qcAfkirInstance, field: "updatedBy")}</td>
								
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
