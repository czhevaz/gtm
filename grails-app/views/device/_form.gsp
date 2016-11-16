<%@ page import="com.smanggin.trackingmanagement.Device" %>



			<div class="form-group fieldcontain ${hasErrors(bean: deviceInstance, field: 'ipAddress', 'error')} ">
				<label for="ipAddress" class="col-sm-3 control-label"><g:message code="device.ipAddress.label" default="Ip Address" /></label>
				<div class="col-sm-9">
					<g:textField name="ipAddress" class="form-control" value="${deviceInstance?.ipAddress}"/>
					<span class="help-inline">${hasErrors(bean: deviceInstance, field: 'ipAddress', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: deviceInstance, field: 'transactionGroup', 'error')} required">
				<label for="transactionGroup" class="col-sm-3 control-label"><g:message code="device.transactionGroup.label" default="Transaction Group" /><span class="required-indicator">*</span></label>
				<div class="col-sm-9">
					<g:select id="transactionGroup" name="transactionGroup.serverId" from="${com.smanggin.trackingmanagement.TransactionGroup.list()}" optionKey="serverId" required="" value="${deviceInstance?.transactionGroup?.serverId}" class="many-to-one form-control chosen-select"/>
					<span class="help-inline">${hasErrors(bean: deviceInstance, field: 'transactionGroup', 'error')}</span>
				</div>
			</div>


			<div class="form-group fieldcontain ${hasErrors(bean: deviceInstance, field: 'line', 'error')} required">
				<label for="line" class="col-sm-3 control-label"><g:message code="device.line.label" default="Line" /><span class="required-indicator">*</span></label>
				<div class="col-sm-9">
					<g:select id="line" name="line.serverId" from="${com.smanggin.trackingmanagement.Line.list()}" optionKey="serverId" required="" value="${deviceInstance?.line?.serverId}" class="many-to-one form-control chosen-select"/>
					<span class="help-inline">${hasErrors(bean: deviceInstance, field: 'line', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: deviceInstance, field: 'plant', 'error')} required">
				<label for="plant" class="col-sm-3 control-label"><g:message code="device.plant.label" default="Plant" /><span class="required-indicator">*</span></label>
				<div class="col-sm-9">
					<g:select id="plant" name="plant.serverId" from="${com.smanggin.trackingmanagement.Plant.list()}" optionKey="serverId" required="" value="${deviceInstance?.plant?.serverId}" class="many-to-one form-control chosen-select"/>
					<span class="help-inline">${hasErrors(bean: deviceInstance, field: 'plant', 'error')}</span>
				</div>
			</div>
			<div class="form-group fieldcontain ${hasErrors(bean: deviceInstance, field: 'item', 'error')} required">
				<label for="item" class="col-sm-3 control-label"><g:message code="device.plant.label" default="Tracked Item" /><span class="required-indicator">*</span></label>
				<div class="col-sm-5">
					<g:select id="item" name="item.serverId" from="${com.smanggin.trackingmanagement.Item.list()}" optionKey="serverId" required="" value="${deviceInstance?.item?.serverId}" class="many-to-one form-control chosen-select"/>
					<span class="help-inline">${hasErrors(bean: deviceInstance, field: 'item', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: deviceInstance, field: 'active', 'error')} ">
				<label for="active" class="col-sm-3 control-label"><g:message code="device.active.label" default="active" /></label>
				<div class="col-sm-9">
					<bs:checkBox name="active" value="${deviceInstance?.active}" />
					<span class="help-inline">${hasErrors(bean: deviceInstance, field: 'active', 'error')}</span>
				</div>
			</div>


