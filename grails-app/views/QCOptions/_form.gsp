<%@ page import="com.smanggin.trackingmanagement.QCOptions" %>



			<div class="form-group fieldcontain ${hasErrors(bean: QCOptionsInstance, field: 'description', 'error')} ">
				<label for="description" class="col-sm-3 control-label"><g:message code="QCOptions.description.label" default="Description" /></label>
				<div class="col-sm-9">
					<g:textField name="description" class="form-control" value="${QCOptionsInstance?.description}"/>
					<span class="help-inline">${hasErrors(bean: QCOptionsInstance, field: 'description', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: QCOptionsInstance, field: 'updatedBy', 'error')} ">
				<label for="updatedBy" class="col-sm-3 control-label"><g:message code="QCOptions.updatedBy.label" default="Updated By" /></label>
				<div class="col-sm-9">
					<g:textField name="updatedBy" class="form-control" value="${QCOptionsInstance?.updatedBy}"/>
					<span class="help-inline">${hasErrors(bean: QCOptionsInstance, field: 'updatedBy', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: QCOptionsInstance, field: 'createdBy', 'error')} ">
				<label for="createdBy" class="col-sm-3 control-label"><g:message code="QCOptions.createdBy.label" default="Created By" /></label>
				<div class="col-sm-9">
					<g:textField name="createdBy" class="form-control" value="${QCOptionsInstance?.createdBy}"/>
					<span class="help-inline">${hasErrors(bean: QCOptionsInstance, field: 'createdBy', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: QCOptionsInstance, field: 'qCMaster', 'error')} required">
				<label for="qCMaster" class="col-sm-3 control-label"><g:message code="QCOptions.qCMaster.label" default="QCM aster" /><span class="required-indicator">*</span></label>
				<div class="col-sm-9">
					<g:select id="qCMaster" name="qCMaster.id" from="${com.smanggin.trackingmanagement.QCMaster.list()}" optionKey="id" required="" value="${QCOptionsInstance?.qCMaster?.id}" class="many-to-one form-control chosen-select"/>
					<span class="help-inline">${hasErrors(bean: QCOptionsInstance, field: 'qCMaster', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: QCOptionsInstance, field: 'qCQuestions', 'error')} required">
				<label for="qCQuestions" class="col-sm-3 control-label"><g:message code="QCOptions.qCQuestions.label" default="QCQ uestions" /><span class="required-indicator">*</span></label>
				<div class="col-sm-9">
					<g:select id="qCQuestions" name="qCQuestions.id" from="${com.smanggin.trackingmanagement.QCQuestions.list()}" optionKey="id" required="" value="${QCOptionsInstance?.qCQuestions?.id}" class="many-to-one form-control chosen-select"/>
					<span class="help-inline">${hasErrors(bean: QCOptionsInstance, field: 'qCQuestions', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: QCOptionsInstance, field: 'serverId', 'error')} ">
				<label for="serverId" class="col-sm-3 control-label"><g:message code="QCOptions.serverId.label" default="Server Id" /></label>
				<div class="col-sm-9">
					<g:textField name="serverId" class="form-control" value="${QCOptionsInstance?.serverId}"/>
					<span class="help-inline">${hasErrors(bean: QCOptionsInstance, field: 'serverId', 'error')}</span>
				</div>
			</div>



