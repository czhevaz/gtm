<div id="searchModal" class="modal fade  " tabindex="-1" role="dialog" aria-labelledby="myModalLabel" >
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
        
            <div class="modal-header">
            		<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        			<h4 class="modal-title" id="myModalLabel">Items <span id="plantName"></span></h4>
            </div>
            <g:form  method="post"  controller="${params.controller}" action="printPdf" target="_blank"  class="form-horizontal" >
            <div class="modal-body">
        		<div class="row">
		        	<div class="col-lg-12">
						<div class="form-group fieldcontain ${hasErrors(bean: receiveItemInstance, field: 'startDate', 'error')} required">
							<label for="startDate" class="col-sm-3 control-label"><g:message code="receiveItem.startDate.label" default="Start Date" /><span class="required-indicator">*</span></label>
							<div class="col-sm-9">
								<bs:datePicker name="startDate" precision="day"  value="${params?.startDate}"  />
								
							</div>
						</div>

						<div class="form-group fieldcontain ${hasErrors(bean: receiveItemInstance, field: 'endDate', 'error')} required">
							<label for="endDate" class="col-sm-3 control-label"><g:message code="receiveItem.endDate.label" default="End Date" /><span class="required-indicator">*</span></label>
							<div class="col-sm-9">
								<bs:datePicker name="endDate" precision="day"  value="${params?.endDate}"  />
								
							</div>
						</div>

						<div class="form-group fieldcontain ${hasErrors(bean: qcAfkirInstance, field: 'plant', 'error')} required">
							<label for="plant" class="col-sm-3 control-label"><g:message code="qcAfkir.plant.label" default="Plant" /><span class="required-indicator">*</span></label>
							<div class="col-sm-9">
								<g:select id="plant" name="plant.serverId" from="${com.smanggin.trackingmanagement.Plant.list()}" optionKey="serverId" required="" value="${params?.plant?.serverId?:session.defaultPlantId}" class="many-to-one form-control .chosen-select-width"/>
								<span class="help-inline">${hasErrors(bean: qcAfkirInstance, field: 'plant', 'error')}</span>
							</div>
						</div>

					</div><!--/.col-lg-12 -->	
		        </div>
			        
            </div><!-- /.modal-body -->
            <div class="modal-footer">
					<button class="btn btn-primary" id="printed"><g:message code="default.button.print.label" default="Print" /></button>
			</div>
            </g:form>
        </div>    
	</div>	
</div>

<r:script>
$(function() {
	    $("body").delegate(".datepicker", "focusin", function(){
	        $(this).datepicker();
	    });
	});
</r:script>