<!doctype html>
<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="layout" content="kickstart" />
    <g:set var="entityName" value="${message(code: 'QCHeader.label', default: 'QCHeader')}" />
    <title>
    <g:if test="${params.trType=='1'}">
    Rejection 
    </g:if>
    <g:if test="${params.trType=='4'}">
    Write Off
    </g:if>
    Analysis by Vendor</title>
</head>

<body>

<section id="show-QCHeader" class="first">
    <div class="row">
        <div class="col-lg-12">
            <ul id="Menu" class="nav nav-pills pull-right">
                <g:form method="post"  controller="${params.controller}" action="printReport" target="_blank" class="form-horizontal" >
                    <g:if test="${params.action == 'report'}">
                        <g:hiddenField name="entityName"   value="${params.trType=='1'?' Rejection':'Write Off'} Analysis by Vendor" />
                        <g:hiddenField name="plantId"   />
                        <g:hiddenField name="itemId"   />
                        <g:hiddenField name="supplierId"   />
                        <g:hiddenField name="startDate"   />
                        <g:hiddenField name="endDate"   />
                        <button type="submit" class="btn btn-danger" id="printPdf" style="display:none;">
                            <img src="${resource(dir: 'images/icon', file: 'pdf.png')}" width="20" /> Print To PDF
                        </button>
                    </g:if>     
                </g:form>
            </ul>   
            
        </div>
        
    </div>
    <div class="row">
        <div class="col-sm-6">  
            <div class="form-group fieldcontain ${hasErrors(bean: QCHeaderInstance, field: 'plant', 'error')} required">
                <label for="plant" class="col-sm-3 control-label"><g:message code="QCHeader.plant.label" default="Plant" /><span class="required-indicator">*</span></label>
                <div class="col-sm-5">
                    <g:select id="plant" name="plant.serverId" from="${com.smanggin.trackingmanagement.Plant.list()}" optionKey="serverId" required="" value="${QCHeaderInstance?.plant?.serverId}" class="many-to-one form-control chosen-select"/>
                    <span class="help-inline">${hasErrors(bean: QCHeaderInstance, field: 'plant', 'error')}</span>
                </div>
            </div>
        </div>  
        <div class="col-sm-6">
            <div class="form-group fieldcontain ${hasErrors(bean: qcAfkirInstance, field: 'item', 'error')} ">
                <label for="item" class="col-sm-3 control-label"><g:message code="qcAfkir.item.label" default="Item" /></label>
                <div class="col-sm-6">
                    <g:select id="item" name="item.serverId" from="${com.smanggin.trackingmanagement.Item.list()}" optionKey="serverId" value="${qcAfkirInstance?.item?.serverId?:session.defaultItemId}" class="many-to-one form-control chosen-select" noSelection="['null': '']"/>
                    <span class="help-inline">${hasErrors(bean: qcAfkirInstance, field: 'item', 'error')}</span>
                </div>
            </div>
        </div>
    </div>

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
            <div class="form-group fieldcontain ${hasErrors(bean: receiveItemInstance, field: 'supplier', 'error')} required">
                <label for="supplier" class="col-sm-3 control-label"><g:message code="receiveItem.supplier.label" default="Supplier" /><span class="required-indicator">*</span></label>
                <div class="col-sm-5">
                    <g:select id="supplier" name="supplier.serverId" from="${com.smanggin.trackingmanagement.Supplier.list()}" optionKey="serverId" required="" value="${params?.supplier?.serverId}" class="many-to-one form-control chosen-select"/>
                    <span class="help-inline">${hasErrors(bean: receiveItemInstance, field: 'supplier', 'error')}</span>
                </div>
            </div>
        </div>
    </div>        
    <div class="row">
        <div class="col-sm-6">  
            <div class="form-actions">  
                  <button class="btn btn-primary" id="processButton"><g:message code="default.button.process.label" default="process" /></button>
            </div>
        </div>  

    </div>

    <div class="row"><div class="col-lg-12"><div class="box box-primary">
    <div  id="div-summary">
        
    </div>
    </div>
    </div>
    </div>

    <div class="row">
        <div class="col-sm-8"> 
        <div class="chart">
            <canvas id="barChart" style="height:230px"></canvas>
        </div>
        </div>
    </div>


    <r:script>
    $('#supplier').prepend("<option value='' >All</option>")
        $("#processButton").on('click', function() {
            
            var data = ifChange();

            $.ajax({
                url: "/${meta(name:'app.name')}/QcAfkir/rejectedAnalysisVendor",
                data: data,
                type: "POST",
                success: function (data) {
                   console.log(data);
                    $("#div-summary").empty();
                    var label = []        
                    var tabel = '<table id="table-summary" class="table table-bordered margin-top-medium">';
                    tabel += '<thead>';
                    tabel += '<tr>';
                    tabel += '<th > Supplier </th>';
                    $.each(data.labelOption, function(j,question) {
                        tabel += '<th>'+question+'</th>';
                    });
                    tabel += '</tr>'
                    
                    tabel += '</thead>'

                    $.each(data.results , function(i,k) {
                        
                        
                        tabel += '<tbody>'
                        tabel += '<tr class="odd">';
                            $.each(k.listValQs, function(j,val) {
                                tabel += '<td>'+val+'</td>';
                            });
                        tabel += '</tr>';
                        tabel +='</tbody>';
                        
                        label.push(k.listValQs[0])
                     });
                    tabel +='</table>';
                    $("#div-summary").append(tabel);        
                    var dataSets=[]
                    $.each(data.labelOption, function(i,val) {
                        var randomColor = '#'+Math.floor(Math.random()*16777215).toString(16);
                        var dataSetObject = {
                          label: val.optionName,
                          fillColor: randomColor,
                          strokeColor: "rgba(210, 214, 222, 1)",
                          pointColor: "rgba(210, 214, 222, 1)",
                          pointStrokeColor: "#c1c7d1",
                          pointHighlightFill: "#fff",
                          pointHighlightStroke: "rgba(220,220,220,1)",
                          data: val.count
                        }
                        dataSets.push(dataSetObject);
                    });

                    var areaChartData = {
                        labels: label,
                        datasets:dataSets
                    }

                    $("#barChart").remove();
                    $('.chart').append('<canvas id="barChart"><canvas>');
                    var barChartCanvas = $("#barChart").get(0).getContext("2d");
                    var barChart = new Chart(barChartCanvas);
                    var barChartData = areaChartData;
                    barChartOptions.datasetFill = false;
                    barChart.Bar(barChartData, barChartOptions);

                    $("#printPdf").show();
                    
                },
                error: function (xhr, status, error) {
                    alert("fail");
                }
            });
            

        });

        function ifChange(){

            var startDate = $('#starDate_year').val() + "-" + $('#starDate_month').val() + "-" + $('#starDate_day').val()+ " 00:00:00";
            var endDate = $('#endDate_year').val() + "-" + $('#endDate_month').val() + "-" + $('#endDate_day').val()+ " 23:59:59";
            var plantServerId = $("#plant").val();
            var supplierId = $("#supplier").val();
            var itemId = $("#item").val();

            /**/
               $("#plantId").val(plantServerId);
                $("#itemId").val(itemId);
                $("#supplierId").val(supplierId);
                $("#startDate").val(startDate);
                $("#endDate").val(endDate);
            /**/
            
            
             
            var data = {
                startDate:startDate,
                endDate:endDate ,
                plantServerId:plantServerId,
                supplierId:supplierId,
                itemId:itemId,
                trType:"${params.trType}"
            }    

                return data
        }
    </r:script> 
</section>

</body>

</html>
