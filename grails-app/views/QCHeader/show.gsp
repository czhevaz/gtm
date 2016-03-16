
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
								<td valign="top" class="name"><g:message code="QCHeader.number.label" default="Number" /></td>
								
								<td valign="top" class="value">${fieldValue(bean: QCHeaderInstance, field: "number")}</td>
								
							</tr>
							<tr class="prop">
								<td valign="top" class="name"><g:message code="QCHeader.transactionGroup.label" default="Transaction Group" /></td>
								
								<td valign="top" class="value"><g:link controller="transactionGroup" action="show" id="${QCHeaderInstance?.transactionGroup?.id}">${QCHeaderInstance?.transactionGroup?.encodeAsHTML()}</g:link></td>
								
							</tr>
							<tr class="prop">
								<td valign="top" class="name"><g:message code="QCHeader.gallon.label" default="Gallon" /></td>
								
								<td valign="top" class="value"><g:link controller="gallon" action="show" id="${QCHeaderInstance?.gallon?.id}">${QCHeaderInstance?.gallon?.encodeAsHTML()}</g:link></td>
								
							</tr>
						
									
							<tr class="prop">
								<td valign="top" class="name"><g:message code="QCHeader.date.label" default="Date" /></td>
								
								<td valign="top" class="value"><g:formatDate date="${QCHeaderInstance?.date}" /></td>
								
							</tr>
						
						
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="QCHeader.plant.label" default="Plant" /></td>
								
								<td valign="top" class="value"><g:link controller="plant" action="show" id="${QCHeaderInstance?.plant?.id}">${QCHeaderInstance?.plant?.encodeAsHTML()}</g:link></td>
								
							</tr>
							
						
							
							<tr class="prop">
								<td valign="top" class="name"><g:message code="QCHeader.workCenter.label" default="Work Center" /></td>
								
								<td valign="top" class="value"><g:link controller="workCenter" action="show" id="${QCHeaderInstance?.workCenter?.id}">${QCHeaderInstance?.workCenter?.encodeAsHTML()}</g:link></td>
								
							</tr>

							
							<tr class="prop">
								<td valign="top" class="name"><g:message code="QCHeader.createdBy.label" default="Created By" /></td>
								
								<td valign="top" class="value">${fieldValue(bean: QCHeaderInstance, field: "createdBy")}</td>
								
							</tr>

								<tr class="prop">
								<td valign="top" class="name"><g:message code="QCHeader.dateCreated.label" default="Date Created" /></td>
								
								<td valign="top" class="value"><g:formatDate date="${QCHeaderInstance?.dateCreated}" /></td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="QCHeader.updatedBy.label" default="Updated By" /></td>
								
								<td valign="top" class="value">${fieldValue(bean: QCHeaderInstance, field: "updatedBy")}</td>
								
							</tr>
						

							<tr class="prop">
								<td valign="top" class="name"><g:message code="QCHeader.lastUpdated.label" default="Last Updated" /></td>
								
								<td valign="top" class="value"><g:formatDate date="${QCHeaderInstance?.lastUpdated}" /></td>
								
							</tr>

							<tr class="prop">
								<td valign="top" class="name"><g:message code="QCHeader.qcActions.label" default="Qc Actions" /></td>
								
								<td valign="top" class="value"><g:link controller="QCActions" action="show" id="${QCHeaderInstance?.qcActions?.id}">${QCHeaderInstance?.qcActions?.encodeAsHTML()}</g:link></td>
								
							</tr>

						
						
						</tbody>
					</table>
				</div><!--/.row -->
				<div class="box-footer clearfix">
						
				</div><!--/.box-footer clearfix -->
			</div><!--/.box-body table-responsive -->
		</div><!--/.box box-primary -->
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
											<td>
												<g:if test="${qcQuestionsInstance?.parameterType == 2}"> 
													<g:textArea class="form-control" name="${processQCInstance?.qcMaster?.code}_${qcQuestionsInstance?.sequenceNo}" value="${myService?.valueQCDetail2(QCHeaderInstance,qcQuestionsInstance?.qCMaster,qcQuestionsInstance).join(',')}" rows="5" cols="40" readonly="${actionName=='show'?true:false}"/>
												</g:if>
												<g:else test="${qcQuestionsInstance?.parameterType == 1}"> 
													<g:textArea class="form-control" name="${processQCInstance?.qcMaster?.code}_${qcQuestionsInstance?.sequenceNo}" value="${myService?.valueQCDetail(QCHeaderInstance,qcQuestionsInstance?.qCMaster,qcQuestionsInstance)}" rows="5" cols="40" readonly="${actionName=='show'?true:false}"/>
												</g:else>
											</td>
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

	<div class="row">
		<div class="col-lg-12">
			<div class="box box-primary">
				<div class="box-header with-border">
                  <h3 class="box-title">Action</h3>
                </div><!--/.box-header with-border -->	
				
					<table class="table table-bordered margin-top-medium">
						<thead>
							<tr>
								<td>
								
								</td>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>
								${qcQuestionsInstance?.qcActions?.code}
									<g:textArea class="form-control" name="description" value="${QCHeaderInstance?.qcActions?.description}" rows="5" cols="40" readonly="true"/>
								</td>
							</tr>
										
						</tbody>
					</table>	

					</div><!--/.box-body -->	
			</div><!--/.box box-primary -->	
		</div><!--/.col-lg-12 -->	
	</div><!--/.row -->

</section>

</body>

</html>
