<div class="row">
    <div class="col-lg-12">
        <div class="box box-primary">

            <div class="table-responsive">
            
                <ul id="myTab" class="nav nav-tabs">
                    <li class="active">
                        <a href="#home" data-toggle="tab"><strong><b>Production In Detail</b></strong></a>
                    </li>
                </ul>

                <div id="myTabContent" class="tab-content" style="padding: 20px">
                    <div class="tab-pane fade active in" id="home">
                        <table id="example" class="table" cellspacing="0" width="100%">
                        </table>
                    </div>
                </div>
            </div> <!--/.table-responsive -->

        </div><!--/.box box-primary -->
    </div><!--/.col-lg-12 -->
</div><!--/.row -->

<r:script>
    var table = $('#example').DataTable({
        destroy: true,
        'ajax': '/${meta(name:'app.name')}/productionInDetail/jlist?masterField=${productionInHeaderInstance?.serverId}',
        'order': [[ 1, 'desc' ]],
        "columns": [
            { "title": "Galon No" },
            { "title": "Created Time" }
        ],
        'deferRender': true // Deferred rendering for speed
    });
</r:script>
