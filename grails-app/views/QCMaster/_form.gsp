<%@ page import="com.smanggin.trackingmanagement.QCMaster" %>

			<div class="form-group fieldcontain ${hasErrors(bean: QCMasterInstance, field: 'code', 'error')} required">
				<label for="code" class="col-sm-3 control-label"><g:message code="QCMaster.code.label" default="Code" /><span class="required-indicator">*</span></label>
				<div class="col-sm-5">
					<g:textField name="code" class="form-control" required="" value="${QCMasterInstance?.code}"/>
					<span class="help-inline">${hasErrors(bean: QCMasterInstance, field: 'code', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: QCMasterInstance, field: 'name', 'error')} required">
				<label for="name" class="col-sm-3 control-label"><g:message code="QCMaster.name.label" default="Name" /><span class="required-indicator">*</span></label>
				<div class="col-sm-5">
					<g:textField name="name" class="form-control" required="" value="${QCMasterInstance?.name}"/>
					<span class="help-inline">${hasErrors(bean: QCMasterInstance, field: 'name', 'error')}</span>
				</div>
			</div>


			<div class="form-group fieldcontain ${hasErrors(bean: QCMasterInstance, field: 'active', 'error')} ">
				<label for="active" class="col-sm-3 control-label"><g:message code="QCMaster.active.label" default="Active" /></label>
				<div class="col-sm-5">
					<bs:checkBox name="active" value="${QCMasterInstance?.active}" />
					<span class="help-inline">${hasErrors(bean: QCMasterInstance, field: 'active', 'error')}</span>
				</div>
			</div>





