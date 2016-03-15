<%@ page import="com.smanggin.trackingmanagement.QCQuestions" %>

			<div class="form-group fieldcontain ${hasErrors(bean: QCQuestionsInstance, field: 'qCMaster', 'error')} required">
				<label for="qCMaster" class="col-sm-3 control-label"><g:message code="QCQuestions.qCMaster.label" default="QCM aster" /><span class="required-indicator">*</span></label>
				<div class="col-sm-9">
					<g:select id="qCMaster" name="qCMaster.serverId" from="${com.smanggin.trackingmanagement.QCMaster.list()}" optionKey="serverId" required="" value="${QCQuestionsInstance?.qCMaster?.serverId}" class="many-to-one form-control chosen-select"/>
					<span class="help-inline">${hasErrors(bean: QCQuestionsInstance, field: 'qCMaster', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: QCQuestionsInstance, field: 'sequenceNo', 'error')} ">
				<label for="sequenceNo" class="col-sm-3 control-label"><g:message code="QCQuestions.sequenceNo.label" default="Sequence No" /></label>
				<div class="col-sm-9">
					<g:field type="number" name="sequenceNo" value="${QCQuestionsInstance.sequenceNo}"/>
					<span class="help-inline">${hasErrors(bean: QCQuestionsInstance, field: 'sequenceNo', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: QCQuestionsInstance, field: 'parameterDesc', 'error')} ">
				<label for="parameterDesc" class="col-sm-3 control-label"><g:message code="QCQuestions.parameterDesc.label" default="Parameter Desc" /></label>
				<div class="col-sm-9">
					<g:textField name="parameterDesc" class="form-control" value="${QCQuestionsInstance?.parameterDesc}"/>
					<span class="help-inline">${hasErrors(bean: QCQuestionsInstance, field: 'parameterDesc', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: QCQuestionsInstance, field: 'notes', 'error')} ">
				<label for="notes" class="col-sm-3 control-label"><g:message code="QCQuestions.notes.label" default="Notes" /></label>
				<div class="col-sm-9">
					<g:textField name="notes" class="form-control" value="${QCQuestionsInstance?.notes}"/>
					<span class="help-inline">${hasErrors(bean: QCQuestionsInstance, field: 'notes', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: QCQuestionsInstance, field: 'parameterType', 'error')} required">
				<label for="parameterType" class="col-sm-3 control-label"><g:message code="QCQuestions.parameterType.label" default="Parameter Type" /><span class="required-indicator">*</span></label>
				<div class="col-sm-9">
					
					<g:select id="parameterType" name="parameterType" from="${[[id:0,value:'UserDescribe'],[id:1,value:'SelectOne'], [id:2,value:'Select More Than One']]}" optionKey="id" optionValue="value" required="" value="${transactionGroupInstance?.parameterType}"  noSelection="${['':'']}" class="many-to-one form-control chosen-select-width"/>

					<span class="help-inline">${hasErrors(bean: QCQuestionsInstance, field: 'parameterType', 'error')}</span>
				</div>
			</div>



			
			


