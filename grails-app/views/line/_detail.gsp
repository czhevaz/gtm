<%@ page import="com.smanggin.trackingmanagement.Line" %>

				<%
if(actionName=='edit' || actionName=='show') { 
%>
<div class="easyui-tabs table" style="height:300px">
    
    
    
    
        
    
        
    
        
        <div title='<g:message code="line.lineBalances.label" default="Line Balances" />' style="padding:10px">

            <table id="dg-lineBalances" class="easyui-datagrid" style="height:240px"
            data-options="singleSelect:true, 
            collapsible:true, 
            onClickRow: lineBalancesOnClickRow,
            toolbar: '#tb-lineBalances',
            url:'/${meta(name:'app.name')}/lineBalance/jlist?masterField.name=line&masterField.id=${lineInstance?.id}'">
                <thead>
                    <tr>
                    
                        
                        <th data-options="field:'updatedBy',width:200,editor:'text'">Updated By</th>
                        

                    
                        
                        <th data-options="field:'beginQty',align:'right',formatter:formatNumber,  width:100,editor:{type:'numberbox',options:{precision:2}}">Begin Qty</th>
                        

                    
                        
                        <th data-options="field:'createdBy',width:200,editor:'text'">Created By</th>
                        

                    
                        
                        <th data-options="field:'date',width:200,editor:'text'">Date</th>
                        

                    
                        
                        <th data-options="field:'endQty',align:'right',formatter:formatNumber,  width:100,editor:{type:'numberbox',options:{precision:2}}">End Qty</th>
                        

                    
                        
                        <th data-options="field:'inQty',align:'right',formatter:formatNumber,  width:100,editor:{type:'numberbox',options:{precision:2}}">In Qty</th>
                        

                    
                        <th data-options="field:'lineId',hidden:true">Line</th>
                                 
                        
                        <th data-options="field:'outQty',align:'right',formatter:formatNumber,  width:100,editor:{type:'numberbox',options:{precision:2}}">Out Qty</th>
                        

                    
                        <th data-options="field:'plantId',width:200,
                            formatter:function(value,row){
                                return row.plantName;
                            },
                            editor:{
                                type:'combobox',
                                options:{
                                    valueField:'id',
                                    textField:'name',
                                    url:'/${meta(name:'app.name')}/plant/jlist',
                                    required:true,
                                }
                        }">Plant</th>
                                    
                        
                        <th data-options="field:'serverId',width:200,editor:'text'">Server Id</th>
                        

                    
                    </tr>
                </thead>
            </table>
        </div> 

        
    
        
    
        
    
        
    
        
        <div title='<g:message code="line.workCenters.label" default="Work Centers" />' style="padding:10px">

            <table id="dg-workCenters" class="easyui-datagrid" style="height:240px"
            data-options="singleSelect:true, 
            collapsible:true, 
            onClickRow: workCentersOnClickRow,
            toolbar: '#tb-workCenters',
            url:'/${meta(name:'app.name')}/workCenter/jlist?masterField.name=line&masterField.id=${lineInstance?.id}'">
                <thead>
                    <tr>
                    
                        
                        <th data-options="field:'name',width:200,editor:'text'">Name</th>
                        

                    
                        
                        <th data-options="field:'updatedBy',width:200,editor:'text'">Updated By</th>
                        

                    
                        
                        <th data-options="field:'createdBy',width:200,editor:'text'">Created By</th>
                        

                    
                        <th data-options="field:'lineId',hidden:true">Line</th>
                                 
                        <th data-options="field:'plantId',width:200,
                            formatter:function(value,row){
                                return row.plantName;
                            },
                            editor:{
                                type:'combobox',
                                options:{
                                    valueField:'id',
                                    textField:'name',
                                    url:'/${meta(name:'app.name')}/plant/jlist',
                                    required:true,
                                }
                        }">Plant</th>
                                    
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
                    {lineId: ${lineInstance.id? lineInstance.id : 0} });
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

        
                    //plantName
                    var ed = $('#dg-workCenters').datagrid('getEditor', {index:editIndex,field:'plantId'});
                    var plantName = $(ed.target).combobox('getText');
                    $('#dg-workCenters').datagrid('getRows')[editIndex]['plantName'] = plantName;
                    
        
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
                    {lineId: ${lineInstance.id? lineInstance.id : 0} });
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
