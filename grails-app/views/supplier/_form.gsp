<%@ page import="com.smanggin.trackingmanagement.Supplier" %>

			<div class="form-group fieldcontain ${hasErrors(bean: supplierInstance, field: 'name', 'error')} ">
				<label for="name" class="col-sm-3 control-label"><g:message code="supplier.name.label" default="Name" /></label>
				<div class="col-sm-9">
					<g:textField name="name" class="form-control" value="${supplierInstance?.name}"/>
					<span class="help-inline">${hasErrors(bean: supplierInstance, field: 'name', 'error')}</span>
				</div>
			</div>


			<div class="form-group fieldcontain ${hasErrors(bean: supplierInstance, field: 'code', 'error')} ">
				<label for="code" class="col-sm-3 control-label"><g:message code="supplier.code.label" default="Code" /></label>
				<div class="col-sm-9">
					<g:textField name="code" class="form-control" value="${supplierInstance?.code}"/>
					<span class="help-inline">${hasErrors(bean: supplierInstance, field: 'code', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: supplierInstance, field: 'postCode', 'error')} ">
				<label for="postCode" class="col-sm-3 control-label"><g:message code="supplier.postCode.label" default="Post Code" /></label>
				<div class="col-sm-9">
					<g:textField name="postCode" class="form-control" value="${supplierInstance?.postCode}"/>
					<span class="help-inline">${hasErrors(bean: supplierInstance, field: 'postCode', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: supplierInstance, field: 'phones', 'error')} ">
				<label for="phones" class="col-sm-3 control-label"><g:message code="supplier.phones.label" default="Phones" /></label>
				<div class="col-sm-9">
					<g:textField name="phones" class="form-control" value="${supplierInstance?.phones}"/>
					<span class="help-inline">${hasErrors(bean: supplierInstance, field: 'phones', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: supplierInstance, field: 'telex', 'error')} ">
				<label for="telex" class="col-sm-3 control-label"><g:message code="supplier.telex.label" default="Telex" /></label>
				<div class="col-sm-9">
					<g:textField name="telex" class="form-control" value="${supplierInstance?.telex}"/>
					<span class="help-inline">${hasErrors(bean: supplierInstance, field: 'telex', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: supplierInstance, field: 'fax', 'error')} ">
				<label for="fax" class="col-sm-3 control-label"><g:message code="supplier.fax.label" default="Fax" /></label>
				<div class="col-sm-9">
					<g:textField name="fax" class="form-control" value="${supplierInstance?.fax}"/>
					<span class="help-inline">${hasErrors(bean: supplierInstance, field: 'fax', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: supplierInstance, field: 'email', 'error')} ">
				<label for="email" class="col-sm-3 control-label"><g:message code="supplier.email.label" default="Email" /></label>
				<div class="col-sm-9">
					<g:textField name="email" class="form-control" value="${supplierInstance?.email}"/>
					<span class="help-inline">${hasErrors(bean: supplierInstance, field: 'email', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: supplierInstance, field: 'city', 'error')} ">
				<label for="city" class="col-sm-3 control-label"><g:message code="supplier.city.label" default="City" /></label>
				<div class="col-sm-9">
					<g:textField name="city" class="form-control" value="${supplierInstance?.city}"/>
					<span class="help-inline">${hasErrors(bean: supplierInstance, field: 'city', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: supplierInstance, field: 'state', 'error')} ">
				<label for="state" class="col-sm-3 control-label"><g:message code="supplier.state.label" default="State" /></label>
				<div class="col-sm-9">
					<g:textField name="state" class="form-control" value="${supplierInstance?.state}"/>
					<span class="help-inline">${hasErrors(bean: supplierInstance, field: 'state', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: supplierInstance, field: 'contactPerson', 'error')} ">
				<label for="contactPerson" class="col-sm-3 control-label"><g:message code="supplier.contactPerson.label" default="Contact Person" /></label>
				<div class="col-sm-9">
					<g:textField name="contactPerson" class="form-control" value="${supplierInstance?.contactPerson}"/>
					<span class="help-inline">${hasErrors(bean: supplierInstance, field: 'contactPerson', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: supplierInstance, field: 'mobileNo', 'error')} ">
				<label for="mobileNo" class="col-sm-3 control-label"><g:message code="supplier.mobileNo.label" default="Mobile No" /></label>
				<div class="col-sm-9">
					<g:textField name="mobileNo" class="form-control" value="${supplierInstance?.mobileNo}"/>
					<span class="help-inline">${hasErrors(bean: supplierInstance, field: 'mobileNo', 'error')}</span>
				</div>
			</div>

			
			<div class="form-group fieldcontain ${hasErrors(bean: supplierInstance, field: 'address', 'error')} ">
				<label for="address" class="col-sm-3 control-label"><g:message code="supplier.address.label" default="Address" /></label>
				<div class="col-sm-9">
					<g:textField name="address" class="form-control" value="${supplierInstance?.address}"/>
					<span class="help-inline">${hasErrors(bean: supplierInstance, field: 'address', 'error')}</span>
				</div>
			</div>
