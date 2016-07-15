<!doctype html>
<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="layout" content="kickstart" />
    <g:set var="entityName" value="${message(code: 'gallon.label', default: 'Gallon History')}" />
    <title>Track History</title>
</head>

<body>

<section id="show-QCHeader" class="first">
    <div class="row">
        <div class="col-sm-6">
            <div class="form-group ">
                <label for="item" class="col-sm-3 control-label"><g:message code="QCHeader.plant.label" default="Tracked Item" /><span class="required-indicator">*</span></label>
                <div class="col-sm-5">
                    <g:select id="item" name="item.serverId" from="${com.smanggin.trackingmanagement.Item.list()}" optionKey="serverId" value="${params?.item?.serverId}" class="many-to-one form-control chosen-select"/>
                    
                </div>
            </div>
        </div>
    </div>        
    <div class="row">
        <div class="col-sm-6">
            <div class="form-group fieldcontain">
                <label for="plant" class="col-sm-3 control-label">
                    <span id="itemCode">Gallon</span> ID
                    <span class="required-indicator">*</span>
                </label>
                <div class="col-sm-5">
                    <g:field type="text" name="gallon1" step="any"  class="form-control" value="${params.gallon1}" />
                </div>
            </div>
        </div>
        
        <div class="col-sm-6">
            <div class="form-group fieldcontain">
                <label for="plant" class="col-sm-3 control-label">
                    <g:message code="gallon.plant.label" default="to Gallon ID" />
                    <span class="required-indicator">*</span>
                </label>
                <div class="col-sm-5">
                    <g:field type="text" name="gallon2" step="any"  class="form-control" value="${params.gallon2}" />
                </div>
            </div>
        </div>
    
    </div>

    <div class="row">
        <div class="col-sm-6">
            <div class="form-group fieldcontain">
                <label for="startDate" class="col-sm-3 control-label">
                    <g:message code="gallon.start.date.label" default="Start Date" />
                    <span class="required-indicator">*</span>
                </label>

                <g:jqDatePicker name="starDate" precision="day"  value="${params.starDate}" data-date-format="yyyy-mm-dd" />
            </div>
        </div>
        <div class="col-sm-6">
            <div class="form-group fieldcontain">
                <label for="endDate" class="col-sm-3 control-label">
                    <g:message code="gallon.end.date.label" default="End Date" />
                    <span class="required-indicator">*</span>
                </label>
                <g:jqDatePicker name="endDate" precision="day"  value="${params.starDate}" data-date-format="yyyy-mm-dd" />
            </div>
        </div>
        <div class="clearfix"></div>
    </div>

    <div class="row">
        <div class="col-sm-6">
            <div class="form-actions">
                <button class="btn btn-primary" id="process">
                    <g:message code="default.button.process.label" default="process" />
                </button>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-sm-12 table-responsive">
            <table id="table-summary" class="table table-bordered table-striped  margin-top-medium">
                <thead>
                <tr>
                    <td>No</td>
                    <td>Date</td>
                    <td>Plant</td>
                    <td>Line</td>
                    <td>WorkCenter</td>
                    <td>Transaction Group</td>
                    <td>Number Transaction</td>
                    <td>In</td>
                    <td>Out</td>
                    <td>Cycle Time</td>
                </tr>
                </thead>
                <tbody>

                </tbody>
            </table>
        </div>
    </div>

    


    <r:script>
		$("#process").on('click', function() {
			//alert('hello world');

			var startDate = $('#starDate_year').val() + "-" + $('#starDate_month').val() + "-" + $('#starDate_day').val()+ " 00:00:00";
			var endDate = $('#endDate_year').val() + "-" + $('#endDate_month').val() + "-" + $('#endDate_day').val()+ " 23:59:59";
			var gallonCode = $("#gallon1").val();
            var gallonCode2 = $("#gallon2").val();

			var data = {
				startDate:startDate,
				endDate:endDate ,
				gallonCode:gallonCode,
                gallonCode2:gallonCode2
			}

			$.ajax({
	            url: "/${meta(name:'app.name')}/gallon/gallonHistory",
	            data:data,
	            type:"POST",
	            success: function (d) {
                    console.log(d);
                    $("#table-summary tbody").html("");
    	            
                    $.each(d.results , function(j,l) {    
                        var tr2 ="<tr>";
                            tr2 += "<td>"+l.gallon.code+"</td>";
                            tr2 += "<td colspan=9></td>";
                            tr2 += "</tr>";

                        $("#table-summary tbody").append(tr2);      
                        

                            $.each(l.listDetail , function(i,k) {
                            console.log(l.listDetail[i]);
                            if(i>0){
                                var date1 = l.listDetail[i-1].date;
                                var date2 = l.listDetail[i].date;
                                var diff = Math.abs(date2 - date1);
                                console.log(diff);
                            }
                            
                                var tr ="<tr>";
                                    tr += "<td > "+  (i*1+1) +" </td>";
                                    tr += "<td > "+  k.date +" </td>";
                                    tr += "<td > "+  k.plant +" </td>";
                                    tr += "<td > "+  k.line +" </td>";
                                    tr += "<td > "+  k.workcenter +" </td>";
                                    tr += "<td > "+  k.transactionGroup +" </td>";
                                    tr += "<td > "+  k.number +" </td>";
                                    tr += "<td > "+  k.in +" </td>";
                                    tr += "<td > "+  k.out +" </td>";
                                    tr += "<td > "+  k.duration +"</td>";  
                                    tr += "</tr>";

                                $("#table-summary tbody").append(tr);        
                            });//eand each detail
                            
                    }); 
                    
	            	
	            },
	            error: function (xhr, status, error) {
	                alert("fail");
	            }
        	});
		});

        $("#item").on('change', function() {
            var itemid = $(this).val()
            $.ajax({
                url: "/${meta(name:'app.name')}/item/jshow",
                data: {id:itemid},
                type: "POST",
                success: function (data) {
                    console.log(data);
                    $("#itemCode").text(data.itemInstance.name);
                },
                error: function (xhr, status, error) {
                    alert("fail");
                }
            });
        });

    </r:script>

    <script type="text/javascript">
        //autocomplete PPP
    $("#gallon1,#gallon2").autocomplete({
        source: function(request, response){
            console.log(request);
            request.itemId=$('#item').val();
            $.ajax({
                url: "${createLink(controller:'gallon', action:'gallonAutoComplete')}", // remote datasource
                data: request,
                success: function(data){
                    if(data.length > 0){
                        console.log('testing')
                        response(data); // set the response
                    } else {
                        alert("item code  not found. Try type another Item Code.");
                    }
                },
                error: function(){ // handle server errors
                    /*$.jGrowl("Unable to retrieve Companies", {
                        theme: 'ui-state-error ui-corner-all'   
                    });*/
                },
            });
        },
        minLength: 2, // triggered only after minimum 2 characters have been entered.
        select: function(event, ui) { // event handler when user selects a field from the list.
           // $("#partnerID").val(ui.item.id); // update the hidden field.
        },
    });


</script>

</section>

</body>

</html>
