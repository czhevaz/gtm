<%@ page import="com.smanggin.trackingmanagement.QCOptions" %>


			<div class="form-group fieldcontain ${hasErrors(bean: QCOptionsInstance, field: 'qCQuestions', 'error')} required">
				<label for="qCQuestions" class="col-sm-3 control-label"><g:message code="QCOptions.qCQuestions.label" default="QCQ uestions" /><span class="required-indicator">*</span></label>
				<div class="col-sm-9">
					<g:select id="qCQuestions" name="qCQuestions.serverId" from="${com.smanggin.trackingmanagement.QCQuestions.list()}" optionKey="serverId" required="" value="${QCOptionsInstance?.qCQuestions?.serverId}" class="many-to-one form-control chosen-select"/>
					<span class="help-inline">${hasErrors(bean: QCOptionsInstance, field: 'qCQuestions', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: QCOptionsInstance, field: 'description', 'error')} ">
				<label for="description" class="col-sm-3 control-label"><g:message code="QCOptions.description.label" default="Description" /></label>
				<div class="col-sm-9">
					<g:textField name="description" class="form-control" value="${QCOptionsInstance?.description}"/>
					<span class="help-inline">${hasErrors(bean: QCOptionsInstance, field: 'description', 'error')}</span>
				</div>
			</div>






