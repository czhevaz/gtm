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


			<div class="form-group fieldcontain ${hasErrors(bean: processQCInstance, field: 'process', 'error')} required">
				<label for="process" class="col-sm-3 control-label"><g:message code="processQC.process.label" default="Process" /><span class="required-indicator">*</span></label>
				<div class="col-sm-9">
					<g:select id="process" name="process.serverId" from="${com.smanggin.trackingmanagement.Process.list()}" optionKey="serverId" required="" value="${processQCInstance?.process?.serverId}" class="many-to-one form-control chosen-select"/>
					<span class="help-inline">${hasErrors(bean: processQCInstance, field: 'process', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: processQCInstance, field: 'qcMaster', 'error')} required">
				<label for="qcMaster" class="col-sm-3 control-label"><g:message code="processQC.qcMaster.label" default="Qc Master" /><span class="required-indicator">*</span></label>
				<div class="col-sm-9">
					<g:select id="qcMaster" name="qcMaster.serverId" from="${com.smanggin.trackingmanagement.QCMaster.list()}" optionKey="serverId" required="" value="${processQCInstance?.qcMaster?.serverId}" class="many-to-one form-control chosen-select"/>
					<span class="help-inline">${hasErrors(bean: processQCInstance, field: 'qcMaster', 'error')}</span>
				</div>
			</div>




