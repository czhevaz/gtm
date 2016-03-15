<%@ page import="com.smanggin.trackingmanagement.Plant" %>

				<%
if(actionName=='edit' || actionName=='show') { 
%>
<div class="easyui-tabs table" style="height:300px">
    
    
    
    
        
    
        
    
        
    
        
    
        
    
        
    
        
        <div title='<g:message code="plant.lineBalances.label" default="Line Balances" />' style="padding:10px">

            <table id="dg-lineBalances" class="easyui-datagrid" style="height:240px"
            data-options="singleSelect:true, 
            collapsible:true, 
            onClickRow: lineBalancesOnClickRow,
            toolbar: '#tb-lineBalances',
            url:'/${meta(name:'app.name')}/lineBalance/jlist?masterField.name=plant&masterField.id=${plantInstance?.id}'">
                <thead>
                    <tr>
                    
                        
                        <th data-options="field:'updatedBy',width:200,editor:'text'">Updated By</th>
                        

                    
                        
                        <th data-options="field:'beginQty',align:'right',formatter:formatNumber,  width:100,editor:{type:'numberbox',options:{precision:2}}">Begin Qty</th>
                        

                    
                        
                        <th data-options="field:'createdBy',width:200,editor:'text'">Created By</th>
                        

                    
                        
                        <th data-options="field:'date',width:200,editor:'text'">Date</th>
                        

                    
                        
                        <th data-options="field:'endQty',align:'right',formatter:formatNumber,  width:100,editor:{type:'numberbox',options:{precision:2}}">End Qty</th>
                        

                    
                        
                        <th data-options="field:'inQty',align:'right',formatter:formatNumber,  width:100,editor:{type:'numberbox',options:{precision:2}}">In Qty</th>
                        

                    
                        <th data-options="field:'lineId',width:200,
                            formatter:function(value,row){
                                return row.lineName;
                            },
                            editor:{
                                type:'combobox',
                                options:{
                                    valueField:'id',
                                    textField:'name',
                                    url:'/${meta(name:'app.name')}/line/jlist',
                                    required:true,
                                }
                        }">Line</th>
                                    
                        
                        <th data-options="field:'outQty',align:'right',formatter:formatNumber,  width:100,editor:{type:'numberbox',options:{precision:2}}">Out Qty</th>
                        

                    
                        <th data-options="field:'plantId',hidden:true">Plant</th>
                                 
                        
                        <th data-options="field:'serverId',width:200,editor:'text'">Server Id</th>
                        

                    
                    </tr>
                </thead>
            </table>
        </div> 

        
    
        
    
        
    
        
    
        
    
        
        <div title='<g:message code="plant.productionInHeaders.label" default="Production In Headers" />' style="padding:10px">

            <table id="dg-productionInHeaders" class="easyui-datagrid" style="height:240px"
            data-options="singleSelect:true, 
            collapsible:true, 
            onClickRow: productionInHeadersOnClickRow,
            toolbar: '#tb-productionInHeaders',
            url:'/${meta(name:'app.name')}/productionInHeader/jlist?masterField.name=plant&masterField.id=${plantInstance?.id}'">
                <thead>
                    <tr>
                    
                        
                        <th data-options="field:'updatedBy',width:200,editor:'text'">Updated By</th>
                        

                    
                        
                        <th data-options="field:'createdBy',width:200,editor:'text'">Created By</th>
                        

                    
                        
                        <th data-options="field:'date',width:200,editor:'text'">Date</th>
                        

                    
                        
                        <th data-options="field:'number',width:200,editor:'text'">Number</th>
                        

                    
                        <th data-options="field:'plantId',hidden:true">Plant</th>
                                 
                        
                        <th data-options="field:'serverId',width:200,editor:'text'">Server Id</th>
                        

                    
                        
                        <th data-options="field:'totalGallon',align:'right',formatter:formatNumber,  width:100,editor:{type:'numberbox',options:{precision:2}}">Total Gallon</th>
                        

                    
                        <th data-options="field:'transactionGroupId',width:200,
                            formatter:function(value,row){
                                return row.transactionGroupName;
                            },
                            editor:{
                                type:'combobox',
                                options:{
                                    valueField:'id',
                                    textField:'name',
                                    url:'/${meta(name:'app.name')}/transactionGroup/jlist',
                                    required:true,
                                }
                        }">Transaction Group</th>
                                    
                    </tr>
                </thead>
            </table>
        </div> 

        
    
        
        <div title='<g:message code="plant.qCHeaders.label" default="QCH eaders" />' style="padding:10px">

            <table id="dg-qCHeaders" class="easyui-datagrid" style="height:240px"
            data-options="singleSelect:true, 
            collapsible:true, 
            onClickRow: qCHeadersOnClickRow,
            toolbar: '#tb-qCHeaders',
            url:'/${meta(name:'app.name')}/QCHeader/jlist?masterField.name=plant&masterField.id=${plantInstance?.id}'">
                <thead>
                    <tr>
                    
                        
                        <th data-options="field:'updatedBy',width:200,editor:'text'">Updated By</th>
                        

                    
                        
                        <th data-options="field:'createdBy',width:200,editor:'text'">Created By</th>
                        

                    
                        
                        <th data-options="field:'date',width:200,editor:'text'">Date</th>
                        

                    
                        <th data-options="field:'gallonId',width:200,
                            formatter:function(value,row){
                                return row.gallonName;
                            },
                            editor:{
                                type:'combobox',
                                options:{
                                    valueField:'id',
                                    textField:'name',
                                    url:'/${meta(name:'app.name')}/gallon/jlist',
                                    required:true,
                                }
                        }">Gallon</th>
                                    
                        
                        <th data-options="field:'number',width:200,editor:'text'">Number</th>
                        

                    
                        <th data-options="field:'plantId',hidden:true">Plant</th>
                                 
                        <th data-options="field:'qcActionsId',width:200,
                            formatter:function(value,row){
                                return row.qcActionsName;
                            },
                            editor:{
                                type:'combobox',
                                options:{
                                    valueField:'id',
                                    textField:'name',
                                    url:'/${meta(name:'app.name')}/qcActions/jlist',
                                    required:true,
                                }
                        }">Qc Actions</th>
                                    
                        
                        <th data-options="field:'serverId',width:200,editor:'text'">Server Id</th>
                        

                    
                        <th data-options="field:'transactionGroupId',width:200,
                            formatter:function(value,row){
                                return row.transactionGroupName;
                            },
                            editor:{
                                type:'combobox',
                                options:{
                                    valueField:'id',
                                    textField:'name',
                                    url:'/${meta(name:'app.name')}/transactionGroup/jlist',
                                    required:true,
                                }
                        }">Transaction Group</th>
                                    
                        <th data-options="field:'workCenterId',width:200,
                            formatter:function(value,row){
                                return row.workCenterName;
                            },
                            editor:{
                                type:'combobox',
                                options:{
                                    valueField:'id',
                                    textField:'name',
                                    url:'/${meta(name:'app.name')}/workCenter/jlist',
                                    required:true,
                                }
                        }">Work Center</th>
                                    
                    </tr>
                </thead>
            </table>
        </div> 

        
    
        
    
        
    
        
        <div title='<g:message code="plant.userPlants.label" default="User Plants" />' style="padding:10px">

            <table id="dg-userPlants" class="easyui-datagrid" style="height:240px"
            data-options="singleSelect:true, 
            collapsible:true, 
            onClickRow: userPlantsOnClickRow,
            toolbar: '#tb-userPlants',
            url:'/${meta(name:'app.name')}/userPlants/jlist?masterField.name=plant&masterField.id=${plantInstance?.id}'">
                <thead>
                    <tr>
                    
                        
                        <th data-options="field:'updatedBy',width:200,editor:'text'">Updated By</th>
                        

                    
                        
                        <th data-options="field:'createdBy',width:200,editor:'text'">Created By</th>
                        

                    
                        
                        <th data-options="field:'isNumber',align:'right', width:100,editor:{type:'checkbox',options:{on:'1',off:'0'}}">Is Number</th>
                        

                    
                        <th data-options="field:'plantId',hidden:true">Plant</th>
                                 
                        
                        <th data-options="field:'serverId',width:200,editor:'text'">Server Id</th>
                        

                    
                        <th data-options="field:'userId',width:200,
                            formatter:function(value,row){
                                return row.userName;
                            },
                            editor:{
                                type:'combobox',
                                options:{
                                    valueField:'id',
                                    textField:'name',
                                    url:'/${meta(name:'app.name')}/user/jlist',
                                    required:true,
                                }
                        }">User</th>
                                    
                    </tr>
                </thead>
            </table>
        </div> 

        
    
        
        <div title='<g:message code="plant.workCenters.label" default="Work Centers" />' style="padding:10px">

            <table id="dg-workCenters" class="easyui-datagrid" style="height:240px"
            data-options="singleSelect:true, 
            collapsible:true, 
            onClickRow: workCentersOnClickRow,
            toolbar: '#tb-workCenters',
            url:'/${meta(name:'app.name')}/workCenter/jlist?masterField.name=plant&masterField.id=${plantInstance?.id}'">
                <thead>
                    <tr>
                    
                        
                        <th data-options="field:'name',width:200,editor:'text'">Name</th>
                        

                    
                        
                        <th data-options="field:'updatedBy',width:200,editor:'text'">Updated By</th>
                        

                    
                        
                        <th data-options="field:'createdBy',width:200,editor:'text'">Created By</th>
                        

                    
                        <th data-options="field:'lineId',width:200,
                            formatter:function(value,row){
                                return row.lineName;
                            },
                            editor:{
                                type:'combobox',
                                options:{
                                    valueField:'id',
                                    textField:'name',
                                    url:'/${meta(name:'app.name')}/line/jlist',
                                    required:true,
                                }
                        }">Line</th>
                                    
                        <th data-options="field:'plantId',hidden:true">Plant</th>
                                 
                        <th data-options="field:'processId',width:200,
                            formatter:function(value,row){
                                return row.processName;
                            },
                            editor:{
                                type:'combobox',
                                options:{
                                    valueField:'id',
                                    textField:'name',
                                    url:'/${meta(name:'app.name')}/process/jlist',
                                    required:true,
                                }
                        }">Process</th>
                                    
                        
                        <th data-options="field:'sequenceNo',align:'right',formatter:formatNumber,  width:100,editor:{type:'numberbox',options:{precision:2}}">Sequence No</th>
                        

                    
                        
                        <th data-options="field:'serverId',width:200,editor:'text'">Server Id</th>
                        

                    
                    </tr>
                </thead>
            </table>
        </div> 

        
    
</div>



    

    

    

    

    

    

    

        <div id="tb-lineBalances" style="height:auto">
            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:false" onclick="lineBalancesAppend()">Add</a>
            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:false" onclick="lineBalancesRemoveit()">Remove</a>
            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:false" onclick="lineBalancesAccept()">Save</a>
            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload',plain:false" onclick="lineBalancesRefresh()">Refresh</a>
        </div>
            
        <r:script>     
            var editIndex = undefined;
            function lineBalancesEndEditing(){
                if (editIndex == undefined){return true}
                if ($('#dg-lineBalances').datagrid('validateRow', editIndex)){

        
                    //lineName
                    var ed = $('#dg-lineBalances').datagrid('getEditor', {index:editIndex,field:'lineId'});
                    var lineName = $(ed.target).combobox('getText');
                    $('#dg-lineBalances').datagrid('getRows')[editIndex]['lineName'] = lineName;
                    
        

                    $('#dg-lineBalances').datagrid('endEdit', editIndex);
                    var row = $('#dg-lineBalances').datagrid('getRows')[editIndex]
                    $.ajax({
                      type: "POST",
                      url: "/${meta(name:'app.name')}/lineBalance/jsave",
                      data: row,
                      success: function(data){ 
                          if(!data.success)
                          {
                            alert(data.messages.errors[0].message)
                          }
                      },
                      dataType: 'json'
                    });
                    editIndex = undefined;
                    return true;
                } else {
                    return false;
                }
            }
            function lineBalancesOnClickRow(index){
                if (editIndex != index){
                    if (lineBalancesEndEditing()){
                        $('#dg-lineBalances').datagrid('selectRow', index)
                                .datagrid('beginEdit', index);
                        editIndex = index;
                    } else {
                        $('#dg-lineBalances').datagrid('selectRow', editIndex);
                    }
                }
            }
            function lineBalancesAppend(){
                if (lineBalancesEndEditing()){
                    $('#dg-lineBalances').datagrid('appendRow',
                    {plantId: ${plantInstance.id? plantInstance.id : 0} });
                    editIndex = $('#dg-lineBalances').datagrid('getRows').length-1;
                    $('#dg-lineBalances').datagrid('selectRow', editIndex).datagrid('beginEdit', editIndex);
                }
            }
            function lineBalancesRemoveit(){
                if (editIndex == undefined){return}
                if (!confirm('Are you sure to delete this record?')){ return }

                var row = $('#dg-lineBalances').datagrid('getRows')[editIndex]
                console.log(row)

                $('#dg-lineBalances').datagrid('cancelEdit', editIndex)
                        .datagrid('deleteRow', editIndex);

                $.ajax({
                  type: "POST",
                  url: "/${meta(name:'app.name')}/lineBalance/jdelete/" + row['id'],
                  data: row,
                  success: function(data){ 
                      if(!data.success)
                      {
                            alert(data.messages)
                      }
                  },
                  dataType: 'json'
                });             
                editIndex = undefined;
            }
            function lineBalancesAccept(){
                if (lineBalancesEndEditing()){
                    $('#dg-lineBalances').datagrid('acceptChanges');
                }
            }

            function lineBalancesRefresh(){
                $('#dg-lineBalances').datagrid('reload');
                editIndex = undefined;
            }
        </r:script>  
    

    

    

    

    

    

        <div id="tb-productionInHeaders" style="height:auto">
            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:false" onclick="productionInHeadersAppend()">Add</a>
            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:false" onclick="productionInHeadersRemoveit()">Remove</a>
            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:false" onclick="productionInHeadersAccept()">Save</a>
            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload',plain:false" onclick="productionInHeadersRefresh()">Refresh</a>
        </div>
            
        <r:script>     
            var editIndex = undefined;
            function productionInHeadersEndEditing(){
                if (editIndex == undefined){return true}
                if ($('#dg-productionInHeaders').datagrid('validateRow', editIndex)){

        

                    $('#dg-productionInHeaders').datagrid('endEdit', editIndex);
                    var row = $('#dg-productionInHeaders').datagrid('getRows')[editIndex]
                    $.ajax({
                      type: "POST",
                      url: "/${meta(name:'app.name')}/productionInHeader/jsave",
                      data: row,
                      success: function(data){ 
                          if(!data.success)
                          {
                            alert(data.messages.errors[0].message)
                          }
                      },
                      dataType: 'json'
                    });
                    editIndex = undefined;
                    return true;
                } else {
                    return false;
                }
            }
            function productionInHeadersOnClickRow(index){
                if (editIndex != index){
                    if (productionInHeadersEndEditing()){
                        $('#dg-productionInHeaders').datagrid('selectRow', index)
                                .datagrid('beginEdit', index);
                        editIndex = index;
                    } else {
                        $('#dg-productionInHeaders').datagrid('selectRow', editIndex);
                    }
                }
            }
            function productionInHeadersAppend(){
                if (productionInHeadersEndEditing()){
                    $('#dg-productionInHeaders').datagrid('appendRow',
                    {plantId: ${plantInstance.id? plantInstance.id : 0} });
                    editIndex = $('#dg-productionInHeaders').datagrid('getRows').length-1;
                    $('#dg-productionInHeaders').datagrid('selectRow', editIndex).datagrid('beginEdit', editIndex);
                }
            }
            function productionInHeadersRemoveit(){
                if (editIndex == undefined){return}
                if (!confirm('Are you sure to delete this record?')){ return }

                var row = $('#dg-productionInHeaders').datagrid('getRows')[editIndex]
                console.log(row)

                $('#dg-productionInHeaders').datagrid('cancelEdit', editIndex)
                        .datagrid('deleteRow', editIndex);

                $.ajax({
                  type: "POST",
                  url: "/${meta(name:'app.name')}/productionInHeader/jdelete/" + row['id'],
                  data: row,
                  success: function(data){ 
                      if(!data.success)
                      {
                            alert(data.messages)
                      }
                  },
                  dataType: 'json'
                });             
                editIndex = undefined;
            }
            function productionInHeadersAccept(){
                if (productionInHeadersEndEditing()){
                    $('#dg-productionInHeaders').datagrid('acceptChanges');
                }
            }

            function productionInHeadersRefresh(){
                $('#dg-productionInHeaders').datagrid('reload');
                editIndex = undefined;
            }
        </r:script>  
    

    

        <div id="tb-qCHeaders" style="height:auto">
            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:false" onclick="qCHeadersAppend()">Add</a>
            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:false" onclick="qCHeadersRemoveit()">Remove</a>
            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:false" onclick="qCHeadersAccept()">Save</a>
            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload',plain:false" onclick="qCHeadersRefresh()">Refresh</a>
        </div>
            
        <r:script>     
            var editIndex = undefined;
            function qCHeadersEndEditing(){
                if (editIndex == undefined){return true}
                if ($('#dg-qCHeaders').datagrid('validateRow', editIndex)){

        
                    //gallonName
                    var ed = $('#dg-qCHeaders').datagrid('getEditor', {index:editIndex,field:'gallonId'});
                    var gallonName = $(ed.target).combobox('getText');
                    $('#dg-qCHeaders').datagrid('getRows')[editIndex]['gallonName'] = gallonName;
                    
        
                    //qcActionsName
                    var ed = $('#dg-qCHeaders').datagrid('getEditor', {index:editIndex,field:'qcActionsId'});
                    var qcActionsName = $(ed.target).combobox('getText');
                    $('#dg-qCHeaders').datagrid('getRows')[editIndex]['qcActionsName'] = qcActionsName;
                    
        

                    $('#dg-qCHeaders').datagrid('endEdit', editIndex);
                    var row = $('#dg-qCHeaders').datagrid('getRows')[editIndex]
                    $.ajax({
                      type: "POST",
                      url: "/${meta(name:'app.name')}/QCHeader/jsave",
                      data: row,
                      success: function(data){ 
                          if(!data.success)
                          {
                            alert(data.messages.errors[0].message)
                          }
                      },
                      dataType: 'json'
                    });
                    editIndex = undefined;
                    return true;
                } else {
                    return false;
                }
            }
            function qCHeadersOnClickRow(index){
                if (editIndex != index){
                    if (qCHeadersEndEditing()){
                        $('#dg-qCHeaders').datagrid('selectRow', index)
                                .datagrid('beginEdit', index);
                        editIndex = index;
                    } else {
                        $('#dg-qCHeaders').datagrid('selectRow', editIndex);
                    }
                }
            }
            function qCHeadersAppend(){
                if (qCHeadersEndEditing()){
                    $('#dg-qCHeaders').datagrid('appendRow',
                    {plantId: ${plantInstance.id? plantInstance.id : 0} });
                    editIndex = $('#dg-qCHeaders').datagrid('getRows').length-1;
                    $('#dg-qCHeaders').datagrid('selectRow', editIndex).datagrid('beginEdit', editIndex);
                }
            }
            function qCHeadersRemoveit(){
                if (editIndex == undefined){return}
                if (!confirm('Are you sure to delete this record?')){ return }

                var row = $('#dg-qCHeaders').datagrid('getRows')[editIndex]
                console.log(row)

                $('#dg-qCHeaders').datagrid('cancelEdit', editIndex)
                        .datagrid('deleteRow', editIndex);

                $.ajax({
                  type: "POST",
                  url: "/${meta(name:'app.name')}/QCHeader/jdelete/" + row['id'],
                  data: row,
                  success: function(data){ 
                      if(!data.success)
                      {
                            alert(data.messages)
                      }
                  },
                  dataType: 'json'
                });             
                editIndex = undefined;
            }
            function qCHeadersAccept(){
                if (qCHeadersEndEditing()){
                    $('#dg-qCHeaders').datagrid('acceptChanges');
                }
            }

            function qCHeadersRefresh(){
                $('#dg-qCHeaders').datagrid('reload');
                editIndex = undefined;
            }
        </r:script>  
    

    

    

    

        <div id="tb-userPlants" style="height:auto">
            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:false" onclick="userPlantsAppend()">Add</a>
            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:false" onclick="userPlantsRemoveit()">Remove</a>
            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:false" onclick="userPlantsAccept()">Save</a>
            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload',plain:false" onclick="userPlantsRefresh()">Refresh</a>
        </div>
            
        <r:script>     
            var editIndex = undefined;
            function userPlantsEndEditing(){
                if (editIndex == undefined){return true}
                if ($('#dg-userPlants').datagrid('validateRow', editIndex)){

        
                    //userName
                    var ed = $('#dg-userPlants').datagrid('getEditor', {index:editIndex,field:'userId'});
                    var userName = $(ed.target).combobox('getText');
                    $('#dg-userPlants').datagrid('getRows')[editIndex]['userName'] = userName;
                    
        

                    $('#dg-userPlants').datagrid('endEdit', editIndex);
                    var row = $('#dg-userPlants').datagrid('getRows')[editIndex]
                    $.ajax({
                      type: "POST",
                      url: "/${meta(name:'app.name')}/userPlants/jsave",
                      data: row,
                      success: function(data){ 
                          if(!data.success)
                          {
                            alert(data.messages.errors[0].message)
                          }
                      },
                      dataType: 'json'
                    });
                    editIndex = undefined;
                    return true;
                } else {
                    return false;
                }
            }
            function userPlantsOnClickRow(index){
                if (editIndex != index){
                    if (userPlantsEndEditing()){
                        $('#dg-userPlants').datagrid('selectRow', index)
                                .datagrid('beginEdit', index);
                        editIndex = index;
                    } else {
                        $('#dg-userPlants').datagrid('selectRow', editIndex);
                    }
                }
            }
            function userPlantsAppend(){
                if (userPlantsEndEditing()){
                    $('#dg-userPlants').datagrid('appendRow',
                    {plantId: ${plantInstance.id? plantInstance.id : 0} });
                    editIndex = $('#dg-userPlants').datagrid('getRows').length-1;
                    $('#dg-userPlants').datagrid('selectRow', editIndex).datagrid('beginEdit', editIndex);
                }
            }
            function userPlantsRemoveit(){
                if (editIndex == undefined){return}
                if (!confirm('Are you sure to delete this record?')){ return }

                var row = $('#dg-userPlants').datagrid('getRows')[editIndex]
                console.log(row)

                $('#dg-userPlants').datagrid('cancelEdit', editIndex)
                        .datagrid('deleteRow', editIndex);

                $.ajax({
                  type: "POST",
                  url: "/${meta(name:'app.name')}/userPlants/jdelete/" + row['id'],
                  data: row,
                  success: function(data){ 
                      if(!data.success)
                      {
                            alert(data.messages)
                      }
                  },
                  dataType: 'json'
                });             
                editIndex = undefined;
            }
            function userPlantsAccept(){
                if (userPlantsEndEditing()){
                    $('#dg-userPlants').datagrid('acceptChanges');
                }
            }

            function userPlantsRefresh(){
                $('#dg-userPlants').datagrid('reload');
                editIndex = undefined;
            }
        </r:script>  
    

    

        <div id="tb-workCenters" style="height:auto">
            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:false" onclick="workCentersAppend()">Add</a>
            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:false" onclick="workCentersRemoveit()">Remove</a>
            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:false" onclick="workCentersAccept()">Save</a>
            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload',plain:false" onclick="workCentersRefresh()">Refresh</a>
        </div>
            
        <r:script>     
            var editIndex = undefined;
            function workCentersEndEditing(){
                if (editIndex == undefined){return true}
                if ($('#dg-workCenters').datagrid('validateRow', editIndex)){

        
                    //lineName
                    var ed = $('#dg-workCenters').datagrid('getEditor', {index:editIndex,field:'lineId'});
                    var lineName = $(ed.target).combobox('getText');
                    $('#dg-workCenters').datagrid('getRows')[editIndex]['lineName'] = lineName;
                    
        
                    //processName
                    var ed = $('#dg-workCenters').datagrid('getEditor', {index:editIndex,field:'processId'});
                    var processName = $(ed.target).combobox('getText');
                    $('#dg-workCenters').datagrid('getRows')[editIndex]['processName'] = processName;
                    
        

                    $('#dg-workCenters').datagrid('endEdit', editIndex);
                    var row = $('#dg-workCenters').datagrid('getRows')[editIndex]
                    $.ajax({
                      type: "POST",
                      url: "/${meta(name:'app.name')}/workCenter/jsave",
                      data: row,
                      success: function(data){ 
                          if(!data.success)
                          {
                            alert(data.messages.errors[0].message)
                          }
                      },
                      dataType: 'json'
                    });
                    editIndex = undefined;
                    return true;
                } else {
                    return false;
                }
            }
            function workCentersOnClickRow(index){
                if (editIndex != index){
                    if (workCentersEndEditing()){
                        $('#dg-workCenters').datagrid('selectRow', index)
                                .datagrid('beginEdit', index);
                        editIndex = index;
                    } else {
                        $('#dg-workCenters').datagrid('selectRow', editIndex);
                    }
                }
            }
            function workCentersAppend(){
                if (workCentersEndEditing()){
                    $('#dg-workCenters').datagrid('appendRow',
                    {plantId: ${plantInstance.id? plantInstance.id : 0} });
                    editIndex = $('#dg-workCenters').datagrid('getRows').length-1;
                    $('#dg-workCenters').datagrid('selectRow', editIndex).datagrid('beginEdit', editIndex);
                }
            }
            function workCentersRemoveit(){
                if (editIndex == undefined){return}
                if (!confirm('Are you sure to delete this record?')){ return }

                var row = $('#dg-workCenters').datagrid('getRows')[editIndex]
                console.log(row)

                $('#dg-workCenters').datagrid('cancelEdit', editIndex)
                        .datagrid('deleteRow', editIndex);

                $.ajax({
                  type: "POST",
                  url: "/${meta(name:'app.name')}/workCenter/jdelete/" + row['id'],
                  data: row,
                  success: function(data){ 
                      if(!data.success)
                      {
                            alert(data.messages)
                      }
                  },
                  dataType: 'json'
                });             
                editIndex = undefined;
            }
            function workCentersAccept(){
                if (workCentersEndEditing()){
                    $('#dg-workCenters').datagrid('acceptChanges');
                }
            }

            function workCentersRefresh(){
                $('#dg-workCenters').datagrid('reload');
                editIndex = undefined;
            }
        </r:script>  
    


<%
}
%>
