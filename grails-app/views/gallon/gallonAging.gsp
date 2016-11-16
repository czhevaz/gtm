<!doctype html>
<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="layout" content="kickstart" />
    <g:set var="entityName" value="${message(code: 'item.aging.label', default: 'Item(s) Aging')}" />
    <title>${entityName}</title>
</head>

<body>

<section id="show-QCHeader" class="first">
    <div class="row">
        <div class="col-lg-12">
            <ul id="Menu" class="nav nav-pills pull-right">
                <g:form method="post"  controller="${params.controller}" action="gallonAging" target="_blank" class="form-horizontal" >
                    <g:if test="${params.action == 'report'}">
                        <g:hiddenField name="printToPdf"  value="true" />
                        <g:hiddenField name="supplierId" id="supplierId" value="" />
                        <g:hiddenField name="parameter1" id="pm1" value="" />
                        <g:hiddenField name="parameter2" id="pm2"  value="" />
                        <g:hiddenField name="parameter3" id="pm3" value="" />
                        <g:hiddenField name="image" id="image" value="" />
                        <button type="submit" class="btn btn-danger" id="printPdf" style="display:block;">
                            <img src="${resource(dir: 'images/icon', file: 'pdf.png')}" width="20" /> Print To PDF
                        </button>
                    </g:if>     
                </g:form>
            </ul>   
            
        </div>
        
    </div>
    <div class="row">
        <div class="col-sm-6">  
            <div class="form-group fieldcontain ${hasErrors(bean: receiveItemInstance, field: 'supplier', 'error')} required">
                <label for="supplier" class="col-sm-3 control-label"><g:message code="receiveItem.supplier.label" default="Supplier" /><span class="required-indicator">*</span></label>
                <div class="col-sm-9">
                    <g:select id="supplier" name="supplier.serverId" from="${com.smanggin.trackingmanagement.Supplier.list()}" optionKey="serverId" required="" value="${params?.supplier?.serverId}"   noSelection="['':'']" class="many-to-one form-control chosen-select"/>
                    <span class="help-inline">${hasErrors(bean: receiveItemInstance, field: 'supplier', 'error')}</span>
                </div>
            </div>
        </div>
    </div>        
    <div class="row">
        <div class="col-sm-6">  
            <div class="form-group fieldcontain ${hasErrors(bean: QCHeaderInstance, field: 'line', 'error')} required">
                <label for="line" class="col-sm-3 control-label"><g:message code="QCHeader.line.label" default="Parameter 1" /><span class="required-indicator">*</span></label>
                <div class="col-sm-5">
                    <g:textField name="parameter1" class="form-control" value="${params.parameter1}"/>
                    <span class="help-inline">${hasErrors(bean: QCHeaderInstance, field: 'line', 'error')}</span>
                </div>
            </div>
        </div>  
    </div>
    <div class="row">
        <div class="col-sm-6">  
            <div class="form-group fieldcontain ${hasErrors(bean: QCHeaderInstance, field: 'line', 'error')} required">
                <label for="line" class="col-sm-3 control-label"><g:message code="QCHeader.line.label" default="Parameter 2" /><span class="required-indicator">*</span></label>
                <div class="col-sm-5">
                    <g:textField name="parameter2" class="form-control" value="${params.parameter2}"/>
                    <span class="help-inline">${hasErrors(bean: QCHeaderInstance, field: 'line', 'error')}</span>
                </div>
            </div>
        </div>  
    </div>
    <div class="row">
        <div class="col-sm-6">  
            <div class="form-group fieldcontain ${hasErrors(bean: QCHeaderInstance, field: 'line', 'error')} required">
                <label for="line" class="col-sm-3 control-label"><g:message code="QCHeader.line.label" default="Parameter 3" /><span class="required-indicator">*</span></label>
                <div class="col-sm-5">
                    <g:textField name="parameter3" class="form-control" value="${params.parameter3}"/>
                    <span class="help-inline">${hasErrors(bean: QCHeaderInstance, field: 'line', 'error')}</span>
                </div>
            </div>
        </div>  
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
                    <td>Supplier</td>
                    <td><span id='span1'>&lt;  1th</span></td>
                    <td><span id='span2'>1 to 2th</span></td>
                    <td><span id='span3'>2 to 3th</span></td>
                    <td><span id='span4'>&ge;  3th</span></td>
                    
                </tr>
                </thead>
                <tbody>

                </tbody>
            </table>
        </div>
    </div>

    <div class="row">
        <div class="col-sm-12"> 
        <div class="chart">
            <canvas id="barChart" style="height:400px"></canvas>
            <div id="js-legend" class="chart-legend"></div>
        </div>
        </div>
    </div>
    

    <g:render template="modalGallonAging"/>    


    <r:script>
        $('#supplier').prepend("<option value='' >All</option>")
        var barChartOptions = {
              //Boolean - Whether the scale should start at zero, or an order of magnitude down from the lowest value
              scaleBeginAtZero: true,
              //Boolean - Whether grid lines are shown across the chart
              scaleShowGridLines: true,
              //String - Colour of the grid lines
              scaleGridLineColor: "rgba(0,0,0,.05)",
              //Number - Width of the grid lines
              scaleGridLineWidth: 1,
              //Boolean - Whether to show horizontal lines (except X axis)
              scaleShowHorizontalLines: true,
              //Boolean - Whether to show vertical lines (except Y axis)
              scaleShowVerticalLines: true,
              //Boolean - If there is a stroke on each bar
              barShowStroke: true,
              //Number - Pixel width of the bar stroke
              barStrokeWidth: 2,
              //Number - Spacing between each of the X value sets
              barValueSpacing: 5,
              //Number - Spacing between data sets within X values
              barDatasetSpacing: 1,
              //String - A legend template
             legend: {
                    display: true,
                    position:'Top',
                    fullWidth:true,
                    labels: {
                        fontColor: 'rgb(255, 99, 132)'
                    }
            },
              //Boolean - whether to make the chart responsive
              responsive: true,
              maintainAspectRatio: true,
              bezierCurve : false,
            onAnimationComplete: done
            };

        

		$("#process").on('click', function() {

			var supplierId = $("#supplier").val();
            var parameter1 = $("#parameter1").val();
            var parameter2 = $("#parameter2").val();
            var parameter3 = $("#parameter3").val();

            $("#supplierId").val(supplierId);
            $("#pm1").val(parameter1);
            $("#pm2").val(parameter2);
            $("#pm3").val(parameter3);

			var data = {
				supplierId:supplierId,
                parameter1:$('#parameter1').val(),
                parameter2:$('#parameter2').val(),
                parameter3:$('#parameter3').val(),
			}

			$.ajax({
	            url: "/${meta(name:'app.name')}/gallon/gallonAging",
	            data:data,
	            type:"POST",
	            success: function (d) {
                    $("#table-summary tbody").html("");
                    var val1 = 0
                    var val2 = 0
                    var val3 = 0
                    var data1 = [];
                    var data2 = [];
                    var data3 = [];
                    var data4 = [];
                    var supplierList = []
                    $.each(d.results , function(i,k) {
                        var tr ="<tr>";
                            tr += "<td > "+  (i*1+1) +" </td>";
                            tr += "<td > "+  k.supplierName +" </td>";
                            tr += "<td onclick=showModal(\'"+k.supplierId+"\',1,'lt');> "+  k.condition1 +" </td>";
                            tr += "<td onclick=showModal(\'"+k.supplierId+"\',2,'lt');> "+  k.condition2 +" </td>";
                            tr += "<td onclick=showModal(\'"+k.supplierId+"\',3,'ge');> "+  k.condition3 +" </td>";  
                            tr += "<td onclick=showModal(\'"+k.supplierId+"\',3,'ge');> "+  k.condition4 +" </td>";  
                            tr += "</tr>";

                        $("#table-summary tbody").append(tr); 

                        val1= val1+k.condition1
                        val2= val2+k.condition2
                        val3= val3+k.condition3       

                        
                        data1.push(k.condition1);
                        data2.push(k.condition2);
                        data3.push(k.condition3);
                        data4.push(k.condition4);

                        supplierList.push(k.supplierName);
                    });
                    
                   
                    
                    var labelx1 = "< "+parameter1
                    var labelx2 = parameter1 +" to "+parameter2
                    var labelx3 = parameter2 +" to "+parameter3
                    var labelx4 = ">= "+parameter3

                    $('#span1').text(labelx1);
                    $('#span2').text(labelx2);
                    $('#span3').text(labelx3);
                    $('#span4').text(labelx4);


                    var areaChartData = {
                      labels: supplierList,
                      datasets: [
                        {
                          label: labelx1,
                          fillColor: "rgba(210, 214, 222, 1)",
                          strokeColor: "rgba(210, 214, 222, 1)",
                          pointColor: "rgba(210, 214, 222, 1)",
                          pointStrokeColor: "#c1c7d1",
                          pointHighlightFill: "#fff",
                          pointHighlightStroke: "rgba(220,220,220,1)",
                          data: data1,
                          bezierCurve : false,
                        },
                        {
                          label: labelx2,
                          fillColor: "rgba(210, 214, 222, 1)",
                          strokeColor: "rgba(210, 214, 222, 1)",
                          pointColor: "rgba(210, 214, 222, 1)",
                          pointStrokeColor: "#c1c7d1",
                          pointHighlightFill: "#fff",
                          pointHighlightStroke: "rgba(220,220,220,1)",
                          data: data2,
                          bezierCurve : false,
                        },
                        {
                          label: labelx3,
                          fillColor: "rgba(210, 214, 222, 1)",
                          strokeColor: "rgba(210, 214, 222, 1)",
                          pointColor: "rgba(210, 214, 222, 1)",
                          pointStrokeColor: "#c1c7d1",
                          pointHighlightFill: "#fff",
                          pointHighlightStroke: "rgba(220,220,220,1)",
                          data: data3,
                          bezierCurve : false,
                        },                     
                        {
                          label: labelx4,
                          fillColor: "rgba(210, 214, 222, 1)",
                          strokeColor: "rgba(210, 214, 222, 1)",
                          pointColor: "rgba(210, 214, 222, 1)",
                          pointStrokeColor: "#c1c7d1",
                          pointHighlightFill: "#fff",
                          pointHighlightStroke: "rgba(220,220,220,1)",
                          data: data4,
                          bezierCurve : false,
                        },                        
                      ]
                    };

                    $("#barChart").remove();
                    $('.chart').append('<canvas id="barChart"><canvas>');
                    var barChartCanvas = $("#barChart").get(0).getContext("2d");
                    var barChart = new Chart(barChartCanvas);
                    var barChartData = areaChartData;
                    barChartData.datasets[0].fillColor = "#00a65a";
                    barChartData.datasets[0].strokeColor = "#00a65a";
                    barChartData.datasets[0].pointColor = "#00a65a"; 
                    barChartData.datasets[1].fillColor = "#F9A825";
                    barChartData.datasets[1].strokeColor = "#F9A825";
                    barChartData.datasets[1].pointColor = "#F9A825"; 
                    barChartData.datasets[2].fillColor = "#FF5722";
                    barChartData.datasets[2].strokeColor = "#FF5722";
                    barChartData.datasets[2].pointColor = "#FF5722"; 

                    barChartOptions.datasetFill = false;
                    var myChart =barChart.Bar(barChartData, barChartOptions);
                    //document.getElementById('js-legend').innerHTML = myChart.generateLegend();
                    
                          
	            	
	            },
	            error: function (xhr, status, error) {
	                alert("fail");
	            }
        	});
		});

    

    /* PRINT */
    $("#printPdf").on('click', function() {
        $("#printToPdf").val(true);
        $("#printToXls").val(false);

        window.open('', target, '');
        this.setAttribute('target', target);
        return;
    });

    function done() {
        console.log('done');
        var url=document.getElementById("barChart").toDataURL();
        $("#image").val(url);
    }

    </r:script>

    
</section>
<style type="text/css">
    .chart-legend li span{
    display: inline-block;
    width: 12px;
    height: 12px;
    margin-right: 5px;
}
</style>
</body>

</html>
