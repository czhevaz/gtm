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
        }, 3000 );
    });

    checkNotif();

    var timernotif = 0;
    clearInterval(timernotif);
    timernotif = setInterval("checkNotif()", 2000);

    function checkNotif() {
        var code = $("#text").val();
        if (code) {
            $.ajax({
                url: "/${meta(name:'app.name')}/QcAfkirDetail/jsave",
                data: {code: code, qcAfkirId: '${qcAfkirInstance?.serverId}'},
                success: function (d) {
                    console.log(d);
                    if (d.success) {
                        $("#text").val('').focus();
                        $("#totalGallon").val(d.count);
                    } else {
                        clearInterval(timernotif);
                        var r = confirm("SCAN ULANG, HARUS UNIQUE");
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
    }

</script>
<%
}
%>
