
<%@ page import="com.smanggin.trackingmanagement.ProductionInHeader" %>
<!doctype html>
<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="layout" content="kickstart" />
    <g:set var="entityName" value="${message(code: 'production.in.header.label', default: 'Production In Header')}" />
    <title><g:message code="default.show.label" args="[entityName]" /></title>
</head>

<body>

<section id="show-user" class="first">
    <div class="row">
        <div class="col-lg-12">
            <div class="box box-primary">
                <div class="box-header with-border">
                    <h3 class="box-title"><g:message code="default.create.label" args="[entityName]" /></h3>
                </div><!--/.box-header with-border -->
                <g:hasErrors bean="${productionInHeaderInstance}">
                    <div class="alert alert-error">
                        <g:renderErrors bean="${productionInHeaderInstance}" as="list" />
                    </div>
                </g:hasErrors>

                <g:form controller="productionInHeader" action="save" class="form-horizontal" >
                    <div class="box-body">
                        <fieldset class="form">

                            <div class="form-group fieldcontain">
                                <label for="date" class="col-sm-3 control-label">
                                    <g:message code="productionInHeader.date.label" default="Date" />
                                </label>
                                <div class="col-sm-5">
                                    <bs:datePicker name="date" precision="day"  value="${productionInHeaderInstance?.date}"  />
                                </div>
                            </div>

                            <div class="form-group fieldcontain">
                                <label for="number" class="col-sm-3 control-label">
                                    <g:message code="productionInHeader.number.label" default="Number" />
                                    <span class="required-indicator">*</span>
                                    <input id="serverId" name="serverId" type="hidden" value="${productionInHeaderInstance?.serverId}">
                                </label>
                                <div class="col-sm-5">
                                    <g:textField name="number" class="form-control" value="${productionInHeaderInstance?.number}" readonly="true"/>
                                </div>
                            </div>

                             <div class="form-group fieldcontain">
                                <label for="plant" class="col-sm-3 control-label">
                                    <g:message code="productionInHeader.plant.label" default="Plant" />
                                </label>
                                <div class="col-sm-5">
                                    <g:select id="plant" name="plant.serverId" readonly="true" from="${com.smanggin.trackingmanagement.Plant.list()}" optionKey="serverId" required="" value="${productionInHeaderInstance?.plant?.serverId}" class="many-to-one form-control chosen-select"/>
                                </div>
                            </div>


                            <div class="form-group fieldcontain">
                                <label for="workCenter" class="col-sm-3 control-label">
                                    <g:message code="productionInHeader.workCenter.label" default="Work Center" />
                                    <span class="required-indicator">*</span>
                                </label>
                                <div class="col-sm-5">
                                    <g:select id="workCenter" name="workCenter.serverId" from="${com.smanggin.trackingmanagement.WorkCenter.list()}" optionKey="serverId" required="" value="${productionInHeaderInstance?.workCenter?.serverId}" class="many-to-one form-control chosen-select"/>
                                    <span class="help-inline">${hasErrors(bean: productionInHeaderInstance, field: 'workCenter', 'error')}</span>
                                </div>
                            </div>

                            <div class="form-group fieldcontain">
                                <label for="shift" class="col-sm-3 control-label">
                                    <g:message code="productionInHeader.shift.label" default="Shift" />
                                </label>
                                <div class="col-sm-5">
                                    <g:select id="shift" name="shift.serverId" readonly="true" from="${com.smanggin.trackingmanagement.Shift.list()}" optionKey="serverId" required="" value="${productionInHeaderInstance?.shift?.serverId}" class="many-to-one form-control chosen-select"/>
                                </div>
                            </div>

                            <div class="form-group fieldcontain">
                                <label for="item" class="col-sm-3 control-label">
                                    <g:message code="productionInHeader.item.label" default="Item" />
                                </label>
                                <div class="col-sm-5">
                                    <g:select id="item" name="item.serverId" readonly="true" from="${com.smanggin.trackingmanagement.Item.list()}" optionKey="serverId" required="" value="${productionInHeaderInstance?.item?.serverId}" class="many-to-one form-control chosen-select"/>
                                </div>
                            </div>


                            <div class="form-group fieldcontain">
                                <label for="totalGallon" class="col-sm-3 control-label">
                                    <g:message code="productionInHeader.totalGallon.label" default="Total Gallon" />
                                </label>
                                <div class="col-sm-5">
                                    <g:textField type="number" name="totalGallon" class="form-control" step="any" required="" value="${productionInHeaderInstance?.totalGallon}" readonly="true"/>
                                </div>
                            </div>

                            <div class="form-group fieldcontain">
                                <label for="transactionGroup" class="col-sm-3 control-label">
                                    <g:message code="productionInHeader.transactionGroup.label" default="Transaction Group" />
                                </label>
                                <div class="col-sm-5">
                                    <g:select id="transactionGroup" name="transactionGroup.serverId" readonly="true" from="${com.smanggin.trackingmanagement.TransactionGroup.list()}" optionKey="serverId" required="" value="${productionInHeaderInstance?.transactionGroup?.serverId}" class="many-to-one form-control chosen-select"/>
                                </div>
                            </div>
                        </fieldset>
                    </div><!--/.box-body -->
                    <div class="box-footer">
                        <div class="form-actions">
                            <g:submitButton name="create" class="btn btn-primary" value="${message(code: 'default.button.save.label', default: 'Save')}" />
                        </div>
                    </div><!--/.box-footer -->
                </g:form>
            </div><!--/.box box-primary -->
        </div><!--/.col-lg-12 -->
    </div><!--/.row -->

    <div class="row">
        <div class="col-lg-12">
            <div class="box box-primary">

                <div class="table-responsive">
                    <div style="padding: 20px">
                        <input id="text" class="form-control input-lg" type="text" placeholder="Scan Barcode">
                    </div>

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

</section>

<script type='text/javascript'>

    var serverId = $('#serverId').val();

    $(document).ready(function() {
        $("#text").focus();
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
                url: "/${meta(name:'app.name')}/productionInDetail/jsave",
                data: {code: code, serverId: serverId},
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

</body>

</html>
