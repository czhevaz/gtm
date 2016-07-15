<!doctype html>
<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="layout" content="kickstart" />
    <g:set var="entityName" value="${message(code: 'QCHeader.label', default: 'QCHeader')}" />
    <title>Write Off </title>
</head>

<body>

<section id="show-QCHeader" class="first">
    
    <div class="row">

        <div class="col-sm-6">
            <div class="form-group fieldcontain ${hasErrors(bean: purchaseOrderInstance, field: 'purchaseOrderDate', 'error')} required">
            <label for="purchaseOrderDate" class="col-sm-3 control-label"><g:message code="purchaseOrder.purchaseOrderDate.label" default="Start Date" /><span class="required-indicator">*</span></label>
            
               <g:jqDatePicker name="starDate" precision="day"  value="${params.starDate}" data-date-format="yyyy-mm-dd" />
            
            </div>
        
            
        </div><!--/.col-lg-12 -->   
        <div class="col-sm-6">
             <div class="form-group fieldcontain ${hasErrors(bean: purchaseOrderInstance, field: 'purchaseOrderDate', 'error')} required">
            <label for="purchaseOrderDate" class="col-sm-3 control-label"><g:message code="purchaseOrder.purchaseOrderDate.label" default="end Date" /><span class="required-indicator">*</span></label>
            
               <g:jqDatePicker name="endDate" precision="day"  value="${params.starDate}" data-date-format="yyyy-mm-dd" />
            
        </div>
        
            
        </div><!--/.col-lg-12 -->
        <div class="clearfix"></div>
        
    </div><!--/.row -->
    <div class="row">
        <div class="col-sm-6">  
            <div class="form-actions">  
                  <button class="btn btn-primary" id="processButton"><g:message code="default.button.process.label" default="process" /></button>
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
                    <td>number </td>
                    <td>Shift </td>
                    <td>Item</td>
                    <td>Total Write Of</td>
                </tr>
                </thead>
                <tbody>

                </tbody>
            </table>
        </div>
    </div>



    <r:script>
        $("#processButton").on('click', function() {
            
               
            var startDate = $('#starDate_year').val() + "-" + $('#starDate_month').val() + "-" + $('#starDate_day').val()+ " 00:00:00";
            var endDate = $('#endDate_year').val() + "-" + $('#endDate_month').val() + "-" + $('#endDate_day').val()+ " 23:59:59";
            
            
            var data = {
                startDate:startDate,
                endDate:endDate ,
            
            }

            $.ajax({
                url: "/${meta(name:'app.name')}/QcAfkir/reportWriteOff",
                data: data,
                type: "POST",
                success: function (data) {
                    console.log(data);  
                    $("#div-summary").empty();        
                    $.each(data.results , function(i,k) {
                        console.log(k);
                        var tabel = '<div class="row"><div class="col-lg-12"><div class="box box-primary"><table id="table-summary" class="table table-bordered margin-top-medium">';
                        tabel += '<div class="box-header with-border"><h3 class="box-title">'+k.lineName+'</h3></div>'
                        tabel += '<thead>';
                        tabel += '<tr>'
                        //tabel += '<th rowspan="2">'+k.qcName+'</th>';
                        $.each(k.listQuestion, function(j,question) {
                            tabel += '<th colspan="'+question.lisOption.length+'">'+question.questionName+'</th>';
                        });

                        tabel += '</tr>';
                        tabel += '<tr>';
                        $.each(k.listQuestion, function(j,question) {
                            if(question.lisOption.length > 0){
                                $.each(question.lisOption, function(k,options) {
                                    tabel += '<th>'+options.optionName+'</th>';
                                });
                            }else{
                                tabel += '<th> other </th>';
                            }
                            
                        });
                        tabel += '</tr>';
                        tabel += '</thead>'
                        tabel += '<tbody>'
                        tabel += '<tr class="odd">';
                            $.each(k.listValQs, function(j,val) {
                                tabel += '<td>'+val+'</td>';
                            });
                        tabel += '</tr>';
                        tabel +='</tbody></table></div></div></div>';
                        $("#div-summary").append(tabel);        

                     });   
                },
                error: function (xhr, status, error) {
                    alert("fail");
                }
            });
        });
    </r:script> 
</section>

</body>

</html>
