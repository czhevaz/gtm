<%@ page import="com.smanggin.trackingmanagement.ReceiveItem" %>

<%
if(actionName=='edit' || actionName=='show') { 
%>
    <div class="row">
        <div class="col-lg-12">
            <div class="box box-primary">

                <div class="table-responsive">
                    
                    <ul id="myTab" class="nav nav-tabs">
                        <li class="active">
                            <a href="#home" data-toggle="tab"><strong><b>Generate Item</b></strong></a>
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
            'ajax': '/${meta(name:'app.name')}/gallon/jlist?receiveId=${receiveItemInstance?.serverId}',
            'order': [[ 1, 'desc' ]],
            "columns": [
                { "title": "Galon No" },
                { "title": "Created Time" }
            ],
            'deferRender': true // Deferred rendering for speed
        });
        
    });

</script>
<%
}
%>
