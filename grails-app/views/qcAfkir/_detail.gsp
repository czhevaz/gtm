<%@ page import="com.smanggin.trackingmanagement.QcAfkir" %>

<%
    if(actionName=='edit' || actionName=='show') { 
%>

    <div class="row">
        <div class="col-lg-12">
            <div class="box box-primary">

                <div class="table-responsive">
                    <div style="padding: 20px">
                        <table class="table table-striped">
                            <tbody>
                                
                                <tr class="prop">
                                    <td valign="top" class="name"><g:message code="receiveItem.totalScan.label" default="Total Item scanned " /></td>
                                    
                                    <td valign="top" class="value"><span id='totalScan'>${qcAfkirInstance?.qcAfkirDetails?.size().encodeAsHTML()}</span></td>
                                    
                                </tr>
                            </tbody>        
                        </table>    

                        <input id="text" class="form-control input-lg" type="text" placeholder="Scan Barcode" onkeydown="keyDown(event);">
                    </div>

                    <ul id="myTab" class="nav nav-tabs">
                        <li class="active">
                            <a href="#home" data-toggle="tab"><strong><b>Afkir Item</b></strong></a>
                        </li>
                    </ul>

                    <div id="myTabContent" class="tab-content" style="padding: 20px">
                        <div class="tab-pane fade active in" id="home">
                            <table id="qcAfkir-Item" class="table" cellspacing="0" width="100%">
                            </table>
                        </div>
                    </div>
                </div> <!--/.table-responsive -->

            </div><!--/.box box-primary -->
        </div><!--/.col-lg-12 -->
    </div><!--/.row -->

    <g:render template="modalAfkir"/> 
</section>

<script type='text/javascript'>

    var serverId = $('#serverId').val();
    e = jQuery.Event("keydown"); // define this once in global scope
    e.which = 13; // Some key value

    var timernotif = 0;

    $(document).ready(function() {
        $("#text").focus();
        var table = $('#qcAfkir-Item').DataTable({
            destroy: true,
            'ajax': '/${meta(name:'app.name')}/QcAfkirDetail/jlist?qcAfkirId=${qcAfkirInstance?.serverId}',
            'order': [[ 1, 'desc' ]],
            "columns": [
                { "title": "Galon No" },
                { "title": "Created Time" }
            ],
            'deferRender': true // Deferred rendering for speed
        });
        setInterval( function () {
            table.ajax.reload(null, false); // user paging is not reset on reload
        }, 500 );
    
        var keyupFiredCount = 0; 

        function DelayExecution(f, delay) {
            var timer = 0; 
            return function () {
                var context = this, args = arguments;
               
                clearTimeout(timer);
                timer = window.setTimeout(function () {
                    f.apply(context, args);
                },
                delay || 100);
            };
        }

        $.fn.ConvertToBarcodeTextbox = function () {
            $(this).focus();

            $(this).keydown(function (event) {
                var keycode = (event.keyCode ? event.keyCode : event.which); 
                var code = $(this).val()
                if ($(this).val() == '') {
                    keyupFiredCount = 0; 
                }  

                if (keycode == 13) {//enter key 
                        //$(".nextcontrol").focus();
                        console.log($(this).val());
                        $.ajax({
                            url: "/${meta(name:'app.name')}/QcAfkirDetail/scanRejectedItem",
                            data: {code: code, qcAfkirId: serverId},
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

                      
                        return false;
                        event.stopPropagation(); 
                } 

            });

            $(this).keyup(DelayExecution(function (event) {
                var keycode = (event.keyCode ? event.keyCode : event.which);  
                keyupFiredCount = keyupFiredCount + 1;  
            }));

            $(this).blur(function (event) { 
             if ($(this).val() == '')
                 return false;

                 if(keyupFiredCount <= 1)
                 {
                    
                 }
                 else 
                 {
                    
                 }

             keyupFiredCount = 0;
            });
        };

        try {
            //$("#text").ConvertToBarcodeTextbox();
            clearInterval(timernotif);
            timernotif = setInterval(function() {$("#text").trigger(e);}, 1000);

        } catch (e) { 
            console.log('tesssdsdsdsdsd')
        }

            $("#modal-qcafkir").on("hidden.bs.modal",function(){
                $("#text").focus();
                $("#totalScan").text(d.totalScan)
            });

    });

    function keyDown(event){
        var code = $("#text").val();
        
        if(code){
            
            ajaxSave(code);
            //clearInterval(timernotif); 

        }
    }

    function ajaxSave(code){
        $.ajax({
            url: "/${meta(name:'app.name')}/QcAfkirDetail/scanRejectedItem",
            data: {code: code, qcAfkirId: serverId},
            success: function (d) {
                console.log(d);
                if (d.success) {
                   $("#text").val('').focus();
                   $("#totalScan").text(d.totalScan)
                   //$("#text").ConvertToBarcodeTextbox();
                    //$("#totalGallon").val(d.count);
                } else {
                    if(d.unique){
                        clearInterval(timernotif);
                        var r = confirm("SCAN ULANG, HARUS UNIQUE");
                        if (r == true) {
                            $("#text").val('').focus();
                            timernotif = setInterval(function() {$("#text").trigger(e);}, 1000);
                        } else {
                            $("#text").val('').focus();
                            timernotif = setInterval(function() {$("#text").trigger(e);}, 1000);
                        }
                    }else{
                        $('#modal-qcafkir').modal('show');    
                    }
                    
                    //$("#text").ConvertToBarcodeTextbox();
                    
                }
            }
        });
    }    


</script>
<%
}
%>

