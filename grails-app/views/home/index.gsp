<html>

<head>
	<title><g:message code="default.welcome.title" args="['Amatra QC Management']"/> </title>
	<meta name="layout" content="kickstart" />
</head>

<body>
	<section>

		<div class="row" >
			<div class="col-md-3 col-sm-6 col-xs-12" id="production">
	          <div class="info-box">
	            <span class="info-box-icon bg-aqua"><i class="icon-windows"></i></span>

	            <div class="info-box-content">
	              <span class="info-box-text">Production In</span>
	              <span class="info-box-number">&nbsp;</span>
	            </div>
	            <!-- /.info-box-content -->
	          </div>
	          <!-- /.info-box -->
	        </div>

	        <!-- QC -->
	        <div class="col-md-3 col-sm-6 col-xs-12" id="qc">
	          <div class="info-box">
	            <span class="info-box-icon bg-red"><i class="icon-foursquare"></i></span>

	            <div class="info-box-content">
	              <span class="info-box-text">QC</span>
	              <span class="info-box-number">&nbsp;</span>
	            </div>
	            <!-- /.info-box-content -->
	          </div>
	          <!-- /.info-box -->
	        </div>

	        <!-- QC -->
	        <div class="col-md-3 col-sm-6 col-xs-12" id="cs">
	          <div class="info-box">
	            <span class="info-box-icon bg-green"><i class="icon-adjust"></i></span>

	            <div class="info-box-content">
	              <span class="info-box-text">Shift Closing</span>
	              <span class="info-box-number">&nbsp;</span>
	            </div>
	            <!-- /.info-box-content -->
	          </div>
	          <!-- /.info-box -->
	        </div>

        </div>

		<div class="row" id="item" style="display: none;">
	    	
		</div>
        
        <div class="row" id="QCItem" style="display: none;">
	    	
		</div>

		<div class="row" id="CSItem" style="display: none;">
	    	
		</div>



	</section>
	<r:script>
		//$(document).ready(function () {
		$.post('/${meta(name:'app.name')}/item/jlist', function(data) {
				
				if(data.length){
					$.each(data, function(a, b){
						var title = b.name;
						var count = data.length;
						var icon = 'icon-qrcode';
						
						var color = 'bg-aqua';
						var link = "/${meta(name:'app.name')}/productionInHeader/production?itemId="+b.id;
						var footerText= "Production In";
						var html = addBox(title,count,icon,color,link,footerText);		
						$('#item').append(html);	

						var color2 = 'bg-red';
						var footerText2= "Qc";
						var link2 = "/${meta(name:'app.name')}/QCHeader/create?itemId="+b.id+"&trType=qc";
						var html2 = addBox(title,count,icon,color2,link2,footerText2);		
						$('#QCItem').append(html2);

						var color3 = 'bg-green';
						var footerText3= "Shift Closing";
						var link3 = "/${meta(name:'app.name')}/closeShift/create?itemId="+b.id+"&trType=cs";
						var html3 = addBox(title,count,icon,color3,link3,footerText3);		
						$('#CSItem').append(html3);

					});		
				}
			
		});

		function addBox(title,count,icon,color,link,footerText){
			
			var html = '<div class="col-lg-3 col-xs-6">' ;
				html += '<div class="small-box '+color+'">';
				html += '<div class="inner">';
				html += '<h3>'+title+'</h3><p>&nbsp;</p>';
				html += '</div>';
				html += '<div class="icon"><i class="'+icon+'"></i></div>';
				html += '<a href="'+link+'" class="small-box-footer">'+footerText+'&nbsp;<i class="icon-circle-arrow-right"></i></a>';
				html += '</div>';
				html += '</div>';        

			return html	
		    
		}

		$('#production').click(function() {
            $('#item').slideToggle("fast");
            $('#QCItem').slideUp();
            $('#CSItem').slideUp();
        });

        $('#qc').click(function() {
            $('#QCItem').slideToggle("fast");
            $('#item').slideUp();
            $('#CSItem').slideUp();
        });

        $('#cs').click(function() {
            $('#CSItem').slideToggle("fast");
            $('#item').slideUp();
            $('#QCItem').slideUp();
        });
	//});
	
	</r:script>
</body>

</html>
