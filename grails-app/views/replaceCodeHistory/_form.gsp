<%@ page import="com.smanggin.trackingmanagement.ReplaceCodeHistory" %>
			
			<div class="form-group fieldcontain ${hasErrors(bean: replaceCodeHistoryInstance, field: 'plant', 'error')} ">
				<label for="plant" class="col-sm-3 control-label"><g:message code="replaceCodeHistory.plant.label" default="Plant" /></label>
				<div class="col-sm-9">
					<g:select id="plant" name="plant.serverId" from="${com.smanggin.trackingmanagement.Plant.list()}" optionKey="serverId"  value="${receiveItemInstance?.plant?.serverId?:session.defaultPlantId}" class="many-to-one form-control chosen-select" noSelection="['null': '']"/>
					<span class="help-inline">${hasErrors(bean: replaceCodeHistoryInstance, field: 'plant', 'error')}</span>
				</div>
			</div>
			<div class="form-group fieldcontain ${hasErrors(bean: replaceCodeHistoryInstance, field: 'item', 'error')} ">
				<label for="item" class="col-sm-3 control-label"><g:message code="qcAfkir.item.label" default="Item" /></label>
				<div class="col-sm-9">
					<g:select id="item" name="item.serverId" from="${com.smanggin.trackingmanagement.Item.list()}" optionKey="serverId" value="${replaceCodeHistoryInstance?.item?.serverId}" class="many-to-one form-control chosen-select" noSelection="['null': '']"/>
					<span class="help-inline">${hasErrors(bean: replaceCodeHistoryInstance, field: 'item', 'error')}</span>
				</div>
			</div>


			<div class="form-group fieldcontain ${hasErrors(bean: replaceCodeHistoryInstance, field: 'reason', 'error')} ">
				<label for="reason" class="col-sm-3 control-label"><g:message code="replaceCodeHistory.reason.label" default="Reason" /></label>
				<div class="col-sm-9">
					<g:textField name="reason" class="form-control" value="${replaceCodeHistoryInstance?.reason}"/>
					<span class="help-inline">${hasErrors(bean: replaceCodeHistoryInstance, field: 'reason', 'error')}</span>
				</div>
			</div>

			<div class="form-group fieldcontain ${hasErrors(bean: replaceCodeHistoryInstance, field: 'oldNumber', 'error')} ">
				<label for="oldNumber" class="col-sm-3 control-label"><g:message code="replaceCodeHistory.oldNumber.label" default="Old Number" /></label>
				<div class="col-sm-9">
					<g:textField name="oldNumber" class="form-control" value="${replaceCodeHistoryInstance?.oldNumber}"/>
					<span class="help-inline">${hasErrors(bean: replaceCodeHistoryInstance, field: 'oldNumber', 'error')}</span>
				</div>
			</div>
			
			<div class="form-group fieldcontain ${hasErrors(bean: replaceCodeHistoryInstance, field: 'newNumber', 'error')} ">
				<label for="newNumber" class="col-sm-3 control-label"><g:message code="replaceCodeHistory.newNumber.label" default="New Number" /></label>
				<div class="col-sm-9">
					<g:textField name="newNumber" class="form-control" value="${replaceCodeHistoryInstance?.newNumber}"/>
					<span class="help-inline">${hasErrors(bean: replaceCodeHistoryInstance, field: 'newNumber', 'error')}</span>
				</div>
			</div>

			
			<g:render template="modalReplaceCode"/> 

<r:script>
/*$(document).ready(function() {
  $(window).keydown(function(event){
    if(event.keyCode == 13) {

      event.preventDefault();
      return false;
    }
  });
});*/
jQuery.extend(jQuery.expr[':'], {
    focusable: function (el, index, selector) {
        return $(el).is('a, button, :input, [tabindex]');
    }
});

$(document).on('keydown', ':focusable', function (e) {
    if (e.which == 13) {
        e.preventDefault();
        // Get all focusable elements on the page
        var $canfocus = $(':focusable');
        var index = $canfocus.index(this) + 1;
        if (index >= $canfocus.length) index = 0;
        $canfocus.eq(index).focus();
    }
});

$('#newNumber').on('keydown', function (e) {
	if (e.which == 13) {
		var plantId = $('#plant').val();
		var reason = $('#plant').val();
		var oldNumber = $('#oldNumber').val();
		var newNumber = $('#newNumber').val();
		var data = {
			plantId:plantId,
			reason:reason,
			oldNumber:oldNumber,
			newNumber:newNumber,
		}

		 $.ajax({
            url: "/${meta(name:'app.name')}/replaceCodeHistory/scanReplaceCodeItem",
            data: data,
            success: function (d) {
                console.log(d);
                if (d.success) {
                   $("#text").val('').focus();
                   //$("#text").ConvertToBarcodeTextbox();
                    //$("#totalGallon").val(d.count);
                } else {
                    $('#modal-qcafkir').modal('show');
                    //$("#text").ConvertToBarcodeTextbox();
                    
                }
            }
        });

	}

})

</r:script>