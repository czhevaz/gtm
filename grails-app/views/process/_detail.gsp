<%@ page import="com.smanggin.trackingmanagement.Process" %>

				<%
if(actionName=='edit' || actionName=='show') { 
%>
<div class="easyui-tabs table" style="height:300px">
    
    
    
    
        
    
        
    
        
    
        
        <div title='<g:message code="process.processQCs.label" default="Process QC s" />' style="padding:10px">

            <table id="dg-processQCs" class="easyui-datagrid" style="height:240px"
            data-options="singleSelect:true, 
            collapsible:true, 
            onClickRow: processQCsOnClickRow,
            toolbar: '#tb-processQCs',
            url:'/${meta(name:'app.name')}/processQC/jlist?masterField.name=process&masterField.id=${processInstance?.id}'">
                <thead>
                    <tr>
                    
                        
                        <th data-options="field:'sequenceNo',align:'right',formatter:formatNumber,  width:100,editor:{type:'numberbox',options:{precision:2}}">Sequence No</th>
                        

                    
                        
                        <th data-options="field:'date1',width:200,editor:'text'">Date1</th>
                        

                    
                        
                        <th data-options="field:'date2',width:200,editor:'text'">Date2</th>
                        

                    
                        
                        <th data-options="field:'updatedBy',width:200,editor:'text'">Updated By</th>
                        

                    
                        
                        <th data-options="field:'createdBy',width:200,editor:'text'">Created By</th>
                        

                    
                        <th data-options="field:'processId',hidden:true">Process</th>
                                 
                        <th data-options="field:'qcMasterId',width:200,
                            formatter:function(value,row){
                                return row.qcMasterName;
                            },
                            editor:{
                                type:'combobox',
                                options:{
                                    valueField:'id',
                                    textField:'name',
                                    url:'/${meta(name:'app.name')}/qcMaster/jlist',
                                    required:true,
                                }
                        }">Qc Master</th>
                                    
                        
                        <th data-options="field:'serverId',width:200,editor:'text'">Server Id</th>
                        

                    
                    </tr>
                </thead>
            </table>
        </div> 

        
    
        
    
        
    
        
        <div title='<g:message code="process.workCenters.label" default="Work Centers" />' style="padding:10px">

            <table id="dg-workCenters" class="easyui-datagrid" style="height:240px"
            data-options="singleSelect:true, 
            collapsible:true, 
            onClickRow: workCentersOnClickRow,
            toolbar: '#tb-workCenters',
            url:'/${meta(name:'app.name')}/workCenter/jlist?masterField.name=process&masterField.id=${processInstance?.id}'">
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
                                    
                        <th data-options="field:'processId',hidden:true">Process</th>
                                 
                        
                        <th data-options="field:'sequenceNo',align:'right',formatter:formatNumber,  width:100,editor:{type:'numberbox',options:{precision:2}}">Sequence No</th>
                        

                    
                        
                        <th data-options="field:'serverId',width:200,editor:'text'">Server Id</th>
                        

                    
                    </tr>
                </thead>
            </table>
        </div> 

        
    
</div>



    

    

    

    

        <div id="tb-processQCs" style="height:auto">
            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:false" onclick="processQCsAppend()">Add</a>
            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:false" onclick="processQCsRemoveit()">Remove</a>
            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:false" onclick="processQCsAccept()">Save</a>
            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload',plain:false" onclick="processQCsRefresh()">Refresh</a>
        </div>
            
        <r:script>     
            var editIndex = undefined;
            function processQCsEndEditing(){
                if (editIndex == undefined){return true}
                if ($('#dg-processQCs').datagrid('validateRow', editIndex)){

        
                    //qcMasterName
                    var ed = $('#dg-processQCs').datagrid('getEditor', {index:editIndex,field:'qcMasterId'});
                    var qcMasterName = $(ed.target).combobox('getText');
                    $('#dg-processQCs').datagrid('getRows')[editIndex]['qcMasterName'] = qcMasterName;
                    
        

                    $('#dg-processQCs').datagrid('endEdit', editIndex);
                    var row = $('#dg-processQCs').datagrid('getRows')[editIndex]
                    $.ajax({
                      type: "POST",
                      url: "/${meta(name:'app.name')}/processQC/jsave",
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
            function processQCsOnClickRow(index){
                if (editIndex != index){
                    if (processQCsEndEditing()){
                        $('#dg-processQCs').datagrid('selectRow', index)
                                .datagrid('beginEdit', index);
                        editIndex = index;
                    } else {
                        $('#dg-processQCs').datagrid('selectRow', editIndex);
                    }
                }
            }
            function processQCsAppend(){
                if (processQCsEndEditing()){
                    $('#dg-processQCs').datagrid('appendRow',
                    {processId: ${processInstance.id? processInstance.id : 0} });
                    editIndex = $('#dg-processQCs').datagrid('getRows').length-1;
                    $('#dg-processQCs').datagrid('selectRow', editIndex).datagrid('beginEdit', editIndex);
                }
            }
            function processQCsRemoveit(){
                if (editIndex == undefined){return}
                if (!confirm('Are you sure to delete this record?')){ return }

                var row = $('#dg-processQCs').datagrid('getRows')[editIndex]
                console.log(row)

                $('#dg-processQCs').datagrid('cancelEdit', editIndex)
                        .datagrid('deleteRow', editIndex);

                $.ajax({
                  type: "POST",
                  url: "/${meta(name:'app.name')}/processQC/jdelete/" + row['id'],
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
            function processQCsAccept(){
                if (processQCsEndEditing()){
                    $('#dg-processQCs').datagrid('acceptChanges');
                }
            }

            function processQCsRefresh(){
                $('#dg-processQCs').datagrid('reload');
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
                    
        
                    //plantName
                    var ed = $('#dg-workCenters').datagrid('getEditor', {index:editIndex,field:'plantId'});
                    var plantName = $(ed.target).combobox('getText');
                    $('#dg-workCenters').datagrid('getRows')[editIndex]['plantName'] = plantName;
                    
        

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
                    {processId: ${processInstance.id? processInstance.id : 0} });
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
