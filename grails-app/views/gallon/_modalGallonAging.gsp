<div id="modalAging" class="modal fade  " tabindex="-1" role="dialog" aria-labelledby="myModalLabel" >
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
            		<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        			<h4 class="modal-title" id="myModalLabel">Items <span id="plantName"></span></h4>
            </div>

            <div class="modal-body">
        		<div class="row">
		        	<div class="col-lg-12">
					<div class="box box-primary">
		        
					<div id="table-content" class=" box-body table-responsive">
		          	<table id="itemsContent" class="table table-bordered  table-striped  table-hover margin-top-medium " style="width:100%;">
						<thead>
							<tr>
								<th>No </th>

								<th>batch No</th>

								<th >Receive Date</th>
								
								<th >Production Date</th>

								<th>Production Line</th>

								<th>Shift</th>

								<th>Group</th>

							</tr>
						</thead>
						<tbody></tbody>
					</table>
					</div><!-- /. -->
					</div><!--/.box box-primary -->	
					</div><!--/.col-lg-12 -->	
		        </div>
			        
            </div><!-- /.modal-body -->
        </div>    
	</div>	
</div>

<style  type="text/css" >
 

.modal-content {
    width: 1100px;
    margin-left: -250px;
}

</style>
<r:script>
	function showModal(plantId,supplierId,variable,operator){
		$('#modalAging').modal('show');
		var data = {
			plantId:plantId,
			supplierId:supplierId,
			variable:variable,
			operator:operator
		}

		$.ajax({
            url: "/${meta(name:'app.name')}/gallon/jlist",
            data:data,
            type:"POST",
            success: function (d) {
              
                console.log(d);
                $("#itemsContent tbody").html("");
                $("#plantName").text(d.plantName);
                $.each(d.data , function(i,k) {
                    var tr ="<tr>";
                        tr += "<td > "+ (i*1+1) +" </td>";
                        tr += "<td > "+ k.code +" </td>";
                        tr += "<td > "+ k.receiveItem.receivedDate +" </td>";
                        tr += "<td > "+ k.receiveItem.productionDate +" </td>";
                        tr += "<td > "+ k.receiveItem.productionLine +" </td>";
                        tr += "<td > "+ k.receiveItem.shift +" </td>";
                        tr += "<td > "+ k.receiveItem.groupShift+" </td>";
                        tr += "</tr>";

                    $("#itemsContent tbody").append(tr);        
                });
            	
            },

            error: function (xhr, status, error) {
                alert("fail");
            }
    	});
	}
</r:script>
