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
        <div class="col-sm-6">  
            <div class="form-group fieldcontain ${hasErrors(bean: receiveItemInstance, field: 'supplier', 'error')} required">
                <label for="supplier" class="col-sm-3 control-label"><g:message code="receiveItem.supplier.label" default="Supplier" /><span class="required-indicator">*</span></label>
                <div class="col-sm-9">
                    <g:select id="supplier" name="supplier.serverId" from="${com.smanggin.trackingmanagement.Supplier.list()}" optionKey="serverId" required="" value="${params?.supplier?.serverId}" class="many-to-one form-control chosen-select"/>
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
                    <td>Received Plant</td>
                    <td>&lt; <span id='span1'>1th</span></td>
                    <td>&lt; <span id='span2'>2th</span></td>
                    <td>&ge; <span id='span3'>3th</span></td>
                    
                </tr>
                </thead>
                <tbody>

                </tbody>
            </table>
        </div>
    </div>

    <div class="row">
        <div class="col-sm-6"> 
        <div class="chart">
            <canvas id="barChart" style="height:230px"></canvas>
        </div>
        </div>
    </div>

    <g:render template="modalGallonAging"/>    


    <r:script>
		$("#process").on('click', function() {
			//alert('hello world');
        
			var supplierId = $("#supplier").val();
            var parameter1 = $("#parameter1").val();
            var parameter2 = $("#parameter2").val();
            var parameter3 = $("#parameter3").val();
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
                    var data = [];
                    $.each(d.results , function(i,k) {
                        var tr ="<tr>";
                            tr += "<td > "+  (i*1+1) +" </td>";
                            tr += "<td > "+  k.plantName +" </td>";
                            tr += "<td onclick=showModal(\'"+k.plantId+"\',\'"+supplierId+"\',1,'lt');> "+  k.condition1 +" </td>";
                            tr += "<td onclick=showModal(\'"+k.plantId+"\',\'"+supplierId+"\',2,'lt');> "+  k.condition2 +" </td>";
                            tr += "<td onclick=showModal(\'"+k.plantId+"\',\'"+supplierId+"\',3,'ge');> "+  k.condition3 +" </td>";  
                            tr += "</tr>";

                        $("#table-summary tbody").append(tr); 

                        val1= val1+k.condition1
                        val2= val2+k.condition2
                        val3= val3+k.condition3       
                    });
                    
                    data.push(val1);
                    data.push(val2);
                    data.push(val3);

                    $('#span1').text(parameter1);
                    $('#span2').text(parameter2);
                    $('#span3').text(parameter3);

                    var labelx1 = "< "+parameter1
                    var labelx2 = "< "+parameter2
                    var labelx3 = ">= "+parameter3
                    var areaChartData = {
                      labels: [labelx1, labelx2, labelx3],
                      datasets: [
                        {
                          label: "",
                          fillColor: "rgba(210, 214, 222, 1)",
                          strokeColor: "rgba(210, 214, 222, 1)",
                          pointColor: "rgba(210, 214, 222, 1)",
                          pointStrokeColor: "#c1c7d1",
                          pointHighlightFill: "#fff",
                          pointHighlightStroke: "rgba(220,220,220,1)",
                          data: data
                        },
                        
                      ]
                    };

                    var barChartCanvas = $("#barChart").get(0).getContext("2d");
                    var barChart = new Chart(barChartCanvas);
                    var barChartData = areaChartData;
                    barChartData.datasets[0].fillColor = "#00a65a";
                    barChartData.datasets[0].strokeColor = "#00a65a";
                    barChartData.datasets[0].pointColor = "#00a65a"; 
                    barChartOptions.datasetFill = false;
                    barChart.Bar(barChartData, barChartOptions);
	            	
	            },
	            error: function (xhr, status, error) {
	                alert("fail");
	            }
        	});
		});


    var randomScalingFactor = function() {
        return (Math.random() > 0.5 ? 1.0 : -1.0) * Math.round(Math.random() * 100);
    };
    var randomColorFactor = function() {
        return Math.round(Math.random() * 255);
    };
    var randomColor = function() {
        return 'rgba(' + randomColorFactor() + ',' + randomColorFactor() + ',' + randomColorFactor() + ',.7)';
    };    

    /*var areaChartData = {
      labels: ["January", "February", "March", "April", "May", "June", "July"],
      datasets: [
        {
          label: "Electronics",
          fillColor: "rgba(210, 214, 222, 1)",
          strokeColor: "rgba(210, 214, 222, 1)",
          pointColor: "rgba(210, 214, 222, 1)",
          pointStrokeColor: "#c1c7d1",
          pointHighlightFill: "#fff",
          pointHighlightStroke: "rgba(220,220,220,1)",
          data: [65, 59, 80, 81, 56, 55, 40]
        },
        {
          label: "Digital Goods",
          fillColor: "rgba(60,141,188,0.9)",
          strokeColor: "rgba(60,141,188,0.8)",
          pointColor: "#3b8bba",
          pointStrokeColor: "rgba(60,141,188,1)",
          pointHighlightFill: "#fff",
          pointHighlightStroke: "rgba(60,141,188,1)",
          data: [28, 48, 40, 19, 86, 27, 90]
        }
      ]
    };*/

    
    //-------------
    //- BAR CHART -
    //-------------
    
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
      
      //Boolean - whether to make the chart responsive
      responsive: true,
      maintainAspectRatio: true
    };

   


    </r:script>

    
</section>

</body>

</html>
