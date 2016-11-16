<div id="modal-qcafkir" class="modal fade  " tabindex="-1" role="dialog" aria-labelledby="myModalLabel" >
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
        
            <div class="modal-header">
            		<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        			<h4 class="modal-title" id="myModalLabel">Items <span id="plantName"></span></h4>
            </div>

            <div class="modal-body">
        		<div class="row">
		        	<div class="col-lg-12">
							<g:form  class="form-horizontal" >
							<div class="form-group fieldcontain ${hasErrors(bean: receiveItemInstance, field: 'supplier', 'error')} required">
							<label for="supplier" class="col-sm-3 control-label"><g:message code="receiveItem.supplier.label" default="Supplier" /><span class="required-indicator">*</span></label>
							<div class="col-sm-4">
							${params?.supplier?.serverId}
								<g:select id="supplier" name="supplier.serverId" from="${com.smanggin.trackingmanagement.Supplier.list()}" optionKey="serverId" required="" value="${params?.supplier?.serverId}" class="many-to-one form-control chosen-select-width"/>
								<span class="help-inline">${hasErrors(bean: receiveItemInstance, field: 'supplier', 'error')}</span>
							</div>
							</div>

							<div class="form-group fieldcontain ${hasErrors(bean: qcAfkirInstance, field: 'year', 'error')} ">
								<label for="number" class="col-sm-3 control-label"><g:message code="gallon.year.label" default="Year" /></label>
								<div class="col-sm-4">
									<g:select id="year" name="year" from="${yearList}"  required="" value="${params.year}" class="many-to-one form-control chosen-select-width"/>
								</div>
							</div>
							<div class="form-group fieldcontain ${hasErrors(bean: qcAfkirInstance, field: 'month', 'error')} ">
								<label for="number" class="col-sm-3 control-label"><g:message code="gallon.month.label" default="Month" /></label>
								<div class="col-sm-4">
									<g:select id="month" name="month" from="${monthList}"  required="" value="${params.month}" class="many-to-one form-control chosen-select-width"/>

									<span class="help-inline">${hasErrors(bean: qcAfkirInstance, field: 'number', 'error')}</span>
								</div>
							</div>
							</g:form>
					</div><!--/.col-lg-12 -->	
		        </div>
			        
            </div><!-- /.modal-body -->
            <div class="modal-footer">
					 <button class="btn btn-primary" id="processButton"><g:message code="default.button.process.label" default="Save" /></button>
			</div>
            
        </div>    
	</div>	
</div>

<r:script>
	$("#processButton").on('click', function() {
		var serverId = $('#serverId').val();
		var code = $('#text').val();
		var qcAfkirId = '${qcAfkirInstance.serverId}'
		var itemId = '${qcAfkirInstance.item.serverId}'
		var supplierId =$('#supplier').val();
		var year =$('#year').val();
		var month =$('#month').val();
		var data = {
			code: code, 
			qcAfkirId:qcAfkirId,
			supplierId:supplierId,
			year:year,
			month:month,
			itemId:itemId
		}
		if (year==null || year=="",month==null || month=="")
	    {
	      alert("Please Fill All Required Field");
	      return false;
	      
	    }else{
			 $.ajax({
	            url: "/${meta(name:'app.name')}/QcAfkirDetail/jsave",
	            data: data,
	            success: function (d) {
	                console.log(d);
	                if (d.success) {
	                   $("#text").val('').focus();
	                   $('#modal-qcafkir').modal('hide');
	                   $("#totalScan").text(d.totalScan);
	                   //$("#text").ConvertToBarcodeTextbox();
	                    //$("#totalGallon").val(d.count);
	                } else {
	                    //$('#modal-qcafkir').modal('show');
	                    //$("#text").ConvertToBarcodeTextbox();
	                    
	                }
	            }
	        });
		}
	});
</r:script>