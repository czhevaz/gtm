<%@ page import="com.smanggin.trackingmanagement.Gallon" %>

			<div class="form-group fieldcontain ${hasErrors(bean: gallonInstance, field: 'code', 'error')} required">
				<label for="code" class="col-sm-3 control-label"><g:message code="gallon.code.label" default="Code" /><span class="required-indicator">*</span></label>
				<div class="col-sm-9">
					<g:textField name="code" class="form-control" required="" value="${gallonInstance?.code}"/>
					<span class="help-inline">${hasErrors(bean: gallonInstance, field: 'code', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: gallonInstance, field: 'item', 'error')} required">
				<label for="item" class="col-sm-3 control-label"><g:message code="QCHeader.plant.label" default="Tracked Item" /><span class="required-indicator">*</span></label>
				<div class="col-sm-5">
					<g:select id="item" name="item.serverId" from="${com.smanggin.trackingmanagement.Item.list()}" optionKey="serverId" required="" value="${gallonInstance?.item?.serverId}" class="many-to-one form-control chosen-select"/>
					<span class="help-inline">${hasErrors(bean: gallonInstance, field: 'item', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: gallonInstance, field: 'writeOff', 'error')} ">
				<label for="writeOff" class="col-sm-3 control-label"><g:message code="gallon.writeOff.label" default="Write Off" /></label>
				<div class="col-sm-9">
					<bs:checkBox name="writeOff" value="${gallonInstance?.writeOff}" />
					<span class="help-inline">${hasErrors(bean: gallonInstance, field: 'writeOff', 'error')}</span>
				</div>
			</div>

			
			