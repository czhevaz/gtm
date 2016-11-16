<!-- 
This menu is used to show function that can be triggered on the content (an object or list of objects).
-->

<%-- Only show the "Pills" navigation menu if a controller exists (but not for home) --%>
<div class ="row">
<div class="col-lg-6">
<g:if test="${	params.controller != null
			&&	params.controller != ''
			&&	params.controller != 'home'
			&&  params.action != 'report'
}">
	<ul id="Menu" class="nav nav-pills">

		<g:set var="entityName" value="${message(code: params.trType?session.trType=='1'?'qcRejected.label':'qcAfkir.label':params.controller+'.label', default: params.controller=='gallon'?session.trackedItem:params.controller.substring(0,1).toUpperCase() + params.controller.substring(1).toLowerCase())}" />
		
		<li class="${ params.action == "list" ? 'active' : '' }">
			<g:link action="list"><i class="icon-th-list"></i> <g:message code="default.list.label" args="[entityName]"/></g:link>
		</li>
		<li class="${ params.action == "create" ? 'active' : '' }">
			<g:link action="create"><i class="icon-plus"></i> <g:message code="default.new.label"  args="[entityName]"/></g:link>
		</li>
		
		<g:if test="${ params.action == 'show' || params.action == 'edit' }">
			<!-- the item is an object (not a list) -->
			<li class="${ params.action == "edit" ? 'active' : '' }">
				<g:link action="edit" params= "[serverId:params.serverId]"><i class="icon-pencil"></i> <g:message code="default.edit.label"  args="[entityName]"/></g:link>
			</li>
			<li class="">
				<g:render template="/_common/modals/deleteTextLink"/>
			</li>
		</g:if>
		
	</ul>
</g:if>
</div >
<div class="col-lg-6">
	<ul id="Menu" class="nav nav-pills pull-right">
		<g:if test="${ (params.action == 'show' || params.action == 'edit') && params.controller == 'receiveItem' }">
		<li class="">
			<g:form method="post"  controller="${params.controller}" action="printPdf" target="_blank" class="form-horizontal" >
				<g:hiddenField name="printId"  value="${params.serverId}" />
				<button type="submit" class="btn btn-danger" id="printPdf" style="display:block;">
					<img src="${resource(dir: 'images/icon', file: 'pdf.png')}" width="20" /> Print To PDF
				</button>
			</g:form>
		</li>
		
		</g:if>
		<g:if test="${params.action == 'list'}">
			<button class="btn btn-danger" id="printPdf" ><img src="${resource(dir: 'images/icon', file: 'pdf.png')}" width="20" /> Print To PDF</button>
			
		</g:if>

		
	</ul>	
	
</div>
</div>
<r:script>
	$("#printPdf").on('click', function() {
		$("#searchModal").modal('show');
	});
	$("#printed").on('click', function() {
		$("#searchModal").modal('hide');
	});
</r:script>