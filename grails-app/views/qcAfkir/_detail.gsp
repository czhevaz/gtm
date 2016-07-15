<%@ page import="com.smanggin.trackingmanagement.QcAfkir" %>

<%
    if(actionName=='edit' || actionName=='show') { 
%>

    <div class="row">
        <div class="col-lg-12">
            <div class="box box-primary">

                <div class="table-responsive">
                    <div style="padding: 20px">
                        <input id="text" class="form-control input-lg" type="text" placeholder="Scan Barcode">
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
            $("#text").ConvertToBarcodeTextbox();

        } catch (e) { 
            console.log('tesssdsdsdsdsd')
        }

    });

    //checkNotif();

    //var timernotif = 0;
    //clearInterval(timernotif);
    //timernotif = setInterval("checkNotif()", 2000);

    /*function checkNotif() {
        var code = $("#text").val();
        if (code) {
            $.ajax({
                url: "/${meta(name:'app.name')}/QcAfkirDetail/scanRejectedItem",
                data: {code: code, qcAfkirId: '${qcAfkirInstance?.serverId}'},
                success: function (d) {
                    console.log(d);
                    if (d.success) {
                        $("#text").val('').focus();
                        $("#totalGallon").val(d.count);
                    } else {
                        console.log('timeout');
                        $('#modal-qcafkir').modal('show');
                       // clearInterval(timernotif);
                        //timernotif = setInterval("checkNotif()", 2000);
                        /* show popup
                        /*var r = confirm("SCAN ULANG, HARUS UNIQUE");
                        if (r == true) {
                            $("#text").val('').focus();
                            timernotif = setInterval("checkNotif()", 2000);
                        } else {
                            $("#text").val('').focus();
                            timernotif = setInterval("checkNotif()", 2000);
                        }
                    }
                }
            });
        }
    }*/

</script>
<%
}
%>

