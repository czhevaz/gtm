<html>

<head>
	<title><g:message code="default.welcome.title" args="['Amatra QC Management']"/> </title>
	<meta name="layout" content="kickstart" />
</head>

<body>
	<section>

		
		<div class="row" id="item">
	    	<div id='rejected'></div>
		</div>
	</section>
	<r:script>
		$(document).ready(function () {
		$.post('/${meta(name:'app.name')}/item/jlist', function(data) {
				
				if(data.length){
					$.each(data, function(a, b){
						var title = b.name;
						var count = data.length;
						var icon = 'icon-qrcode';
						var color = 'bg-aqua';
						var link = "/${meta(name:'app.name')}/productionInHeader/production?itemId="+b.id;
						var html = addBox(title,count,icon,color,link);		
						$('#item').append(html);	
					});		
				}
			
		});

		function addBox(title,count,icon,color,link){
			
			var html = '<div class="col-lg-3 col-xs-6">' ;
				html += '<div class="small-box '+color+'">';
				html += '<div class="inner">';
				html += '<h3><span id="purchaseOrder">';
				html += '<p><b>'+title+'</b></p> </span></h3>';
				html += '</div>';
				html += '<div class="icon"><i class="'+icon+'"></i></div>';
				html += '<a href="'+link+'" class="small-box-footer">Production In<i class="icon-circle-arrow-right"></i></a>';
				html += '</div>';
				html += '</div>';        

			return html	
		    
		}
	});
	
	</r:script>
</body>

</html>
