<%@ page import="com.smanggin.trackingmanagement.ProcessQC" %>



			<div class="form-group fieldcontain ${hasErrors(bean: processQCInstance, field: 'sequenceNo', 'error')} ">
				<label for="sequenceNo" class="col-sm-3 control-label"><g:message code="processQC.sequenceNo.label" default="Sequence No" /></label>
				<div class="col-sm-9">
					<g:field type="number" name="sequenceNo" value="${processQCInstance.sequenceNo}"/>
					<span class="help-inline">${hasErrors(bean: processQCInstance, field: 'sequenceNo', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: processQCInstance, field: 'date1', 'error')} ">
				<label for="date1" class="col-sm-3 control-label"><g:message code="processQC.date1.label" default="Date1" /></label>
				<div class="col-sm-9">
					<bs:datePicker name="date1" precision="day"  value="${processQCInstance?.date1}" default="none" noSelection="['': '']" />
					<span class="help-inline">${hasErrors(bean: processQCInstance, field: 'date1', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: processQCInstance, field: 'date2', 'error')} ">
				<label for="date2" class="col-sm-3 control-label"><g:message code="processQC.date2.label" default="Date2" /></label>
				<div class="col-sm-9">
					<bs:datePicker name="date2" precision="day"  value="${processQCInstance?.date2}" default="none" noSelection="['': '']" />
					<span class="help-inline">${hasErrors(bean: processQCInstance, field: 'date2', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: processQCInstance, field: 'updatedBy', 'error')} ">
				<label for="updatedBy" class="col-sm-3 control-label"><g:message code="processQC.updatedBy.label" default="Updated By" /></label>
				<div class="col-sm-9">
					<g:textField name="updatedBy" class="form-control" value="${processQCInstance?.updatedBy}"/>
					<span class="help-inline">${hasErrors(bean: processQCInstance, field: 'updatedBy', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: processQCInstance, field: 'createdBy', 'error')} ">
				<label for="createdBy" class="col-sm-3 control-label"><g:message code="processQC.createdBy.label" default="Created By" /></label>
				<div class="col-sm-9">
					<g:textField name="createdBy" class="form-control" value="${processQCInstance?.createdBy}"/>
					<span class="help-inline">${hasErrors(bean: processQCInstance, field: 'createdBy', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: processQCInstance, field: 'process', 'error')} required">
				<label for="process" class="col-sm-3 control-label"><g:message code="processQC.process.label" default="Process" /><span class="required-indicator">*</span></label>
				<div class="col-sm-9">
					<g:select id="process" name="process.id" from="${com.smanggin.trackingmanagement.Process.list()}" optionKey="id" required="" value="${processQCInstance?.process?.id}" class="many-to-one form-control chosen-select"/>
					<span class="help-inline">${hasErrors(bean: processQCInstance, field: 'process', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: processQCInstance, field: 'qcMaster', 'error')} required">
				<label for="qcMaster" class="col-sm-3 control-label"><g:message code="processQC.qcMaster.label" default="Qc Master" /><span class="required-indicator">*</span></label>
				<div class="col-sm-9">
					<g:select id="qcMaster" name="qcMaster.id" from="${com.smanggin.trackingmanagement.QCMaster.list()}" optionKey="id" required="" value="${processQCInstance?.qcMaster?.id}" class="many-to-one form-control chosen-select"/>
					<span class="help-inline">${hasErrors(bean: processQCInstance, field: 'qcMaster', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: processQCInstance, field: 'serverId', 'error')} ">
				<label for="serverId" class="col-sm-3 control-label"><g:message code="processQC.serverId.label" default="Server Id" /></label>
				<div class="col-sm-9">
					<g:textField name="serverId" class="form-control" value="${processQCInstance?.serverId}"/>
					<span class="help-inline">${hasErrors(bean: processQCInstance, field: 'serverId', 'error')}</span>
				</div>
			</div>



