<%@ page import="com.smanggin.trackingmanagement.AppSetting" %>



			<div class="form-group fieldcontain ${hasErrors(bean: appSettingInstance, field: 'code', 'error')} ">
				<label for="code" class="col-sm-3 control-label"><g:message code="appSetting.code.label" default="Code" /></label>
				<div class="col-sm-9">
					<g:textField name="code" class="form-control" value="${appSettingInstance?.code}"/>
					<span class="help-inline">${hasErrors(bean: appSettingInstance, field: 'code', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: appSettingInstance, field: 'unit', 'error')} ">
				<label for="unit" class="col-sm-3 control-label"><g:message code="appSetting.unit.label" default="Unit" /></label>
				<div class="col-sm-9">
					<g:textField name="unit" class="form-control" value="${appSettingInstance?.unit}"/>
					<span class="help-inline">${hasErrors(bean: appSettingInstance, field: 'unit', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: appSettingInstance, field: 'val', 'error')} ">
				<label for="val" class="col-sm-3 control-label"><g:message code="appSetting.val.label" default="Val" /></label>
				<div class="col-sm-9">
					<g:textField name="val" class="form-control" value="${appSettingInstance?.val}"/>
					<span class="help-inline">${hasErrors(bean: appSettingInstance, field: 'val', 'error')}</span>
				</div>
			</div>



