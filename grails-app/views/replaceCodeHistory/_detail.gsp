<%@ page import="com.smanggin.trackingmanagement.ReplaceCodeHistory" %>

				<%
if(actionName=='edit' || actionName=='show' || actionName=='create') { 
%>
 	<div class="row">
        <div class="col-lg-12">
            <div class="box box-primary">

                <div class="table-responsive">
                    
                    <ul id="myTab" class="nav nav-tabs">
                        <li class="active">
                            <a href="#home" data-toggle="tab"><strong><b>History Replacement Code</b></strong></a>
                        </li>
                    </ul>

                    <div id="myTabContent" class="tab-content" style="padding: 20px">
                        <div class="tab-pane fade active in" id="home">
                            <table id="replace-code" class="table" cellspacing="0" width="100%">
                            </table>
                        </div>
                    </div>
                </div> <!--/.table-responsive -->

            </div><!--/.box box-primary -->
        </div><!--/.col-lg-12 -->
    </div><!--/.row -->

<script type='text/javascript'>

    $(document).ready(function() {
        $("#text").focus();
        var table = $('#replace-code').DataTable({
            destroy: true,
            'ajax': '/${meta(name:'app.name')}/replaceCodeHistory/jlist?replaceCode=true',
            'order': [[ 2, 'desc' ]],
            "columns": [
                { "title": "Old Number" },
                { "title": "New Number" },
                { "title": "Created Time" }
            ],
            'deferRender': true // Deferred rendering for speed
        });
        setInterval( function () {
            table.ajax.reload(null, false); // user paging is not reset on reload
        }, 500 );
    });
        
</script>        

    

    

    

    

    

    

    


<%
}
%>
