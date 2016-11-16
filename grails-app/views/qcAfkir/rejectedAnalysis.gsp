<!doctype html>
<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="layout" content="kickstart" />
    <g:set var="entityName" value="${message(code: 'QCHeader.label', default: 'QCHeader')}" />
    <title><g:if test="${params.trType=='1'}">
    Rejection 
    </g:if>
    <g:if test="${params.trType=='4'}">
    Write Off
    </g:if> Analysis</title>
</head>

<body>

<section id="show-QCHeader" class="first">
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

    </div>
    <div class="row">
        <div class="col-sm-6">  
            <div class="form-group fieldcontain ${hasErrors(bean: QCHeaderInstance, field: 'line', 'error')} required">
                <label for="line" class="col-sm-3 control-label"><g:message code="QCHeader.line.label" default="Line" /><span class="required-indicator">*</span></label>
                <div class="col-sm-5">
                    <g:select id="line" name="line.serverId" from="${com.smanggin.trackingmanagement.Line.list()}" optionKey="serverId" required="" value="${QCHeaderInstance?.line?.serverId}" class="many-to-one form-control chosen-select"/>
                    <span class="help-inline">${hasErrors(bean: QCHeaderInstance, field: 'line', 'error')}</span>
                </div>
            </div>
        </div>  
        <div class="col-sm-6">  
            <div class="form-group fieldcontain ${hasErrors(bean: QCHeaderInstance, field: 'line', 'error')} required">
                <label for="line" class="col-sm-3 control-label"><g:message code="QCHeader.line.label" default=" to Line" /><span class="required-indicator">*</span></label>
                <div class="col-sm-5">
                    <g:select id="line2" name="line2.serverId" from="${com.smanggin.trackingmanagement.Line.list()}" optionKey="serverId" required="" value="${params?.line2?.serverId}" class="many-to-one form-control chosen-select"/>
                    <span class="help-inline">${hasErrors(bean: QCHeaderInstance, field: 'line2', 'error')}</span>
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
            <div class="form-actions">  
                  <button class="btn btn-primary" id="processButton"><g:message code="default.button.process.label" default="process" /></button>
            </div>
        </div>  

    </div>


    <div class="row" id="div-summary">
        
    </div>

    <div class="row">
        <div class="col-sm-8"> 
        <div class="chart">
            <canvas id="barChart" style="height:230px"></canvas>
        </div>
        </div>
    </div>

    <g:render template="modalReportRejected"/>    
    <r:script>
        $("#processButton").on('click', function() {
            
               
            var startDate = $('#starDate_year').val() + "-" + $('#starDate_month').val() + "-" + $('#starDate_day').val()+ " 00:00:00";
            var endDate = $('#endDate_year').val() + "-" + $('#endDate_month').val() + "-" + $('#endDate_day').val()+ " 23:59:59";
            var plantServerId = $("#plant").val();
            var lineServerId = $("#line").val();
            var line2ServerId = $("#line").val();
            
            
            var data = {
                startDate:startDate,
                endDate:endDate ,
                plantServerId:plantServerId,
                line1ServerId:lineServerId,
                line2ServerId:line2ServerId,
                trType:"${params.trType}"
            }



            $.ajax({
                url: "/${meta(name:'app.name')}/QcAfkir/rejectedAnalysis",
                data: data,
                type: "POST",
                success: function (data) {
                    console.log(data);  
                    $("#div-summary").empty();        
                    var valData=[]
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
                                tabel += "<td onclick=showModal(\'"+k.supplierId+"\',\'"+val.optionId+"\',\'"+val.questioId+"\');>"+val.val+"</td>";
                                valData.push(val.val)
                            });
                        tabel += '</tr>';
                        tabel +='</tbody></table></div></div></div>';
                        $("#div-summary").append(tabel);        

                     });   

                    //chart
                    console.log(data.dataSet.listValQs);
                    var areaChartData = {
                        labels: data.dataSet.labelname,
                        datasets:[
                            {
                              label: 'qty',
                              fillColor: ["rgba(220,220,220,0.5)", "navy", "red", "orange"],
                              strokeColor: "rgba(210, 214, 222, 1)",
                              pointColor: "rgba(210, 214, 222, 1)",
                              pointStrokeColor: "#c1c7d1",
                              pointHighlightFill: "#fff",
                              pointHighlightStroke: "rgba(220,220,220,1)",
                              data: valData
                            }
                        ]
                    }

                    $("#barChart").remove();
                    $('.chart').append('<canvas id="barChart"><canvas>');
                    var barChartCanvas = $("#barChart").get(0).getContext("2d");
                    var barChart = new Chart(barChartCanvas);
                    var barChartData = areaChartData;
                    barChartOptions.datasetFill = false;
                    barChart.Bar(barChartData, barChartOptions);
                },
                error: function (xhr, status, error) {
                    alert("fail");
                }
            });
        });
    
    $(function() {
        $("body").delegate(".datepicker", "focusin", function(){
            $(this).datepicker();
        });
    });

   
    </r:script> 
</section>

</body>

</html>
