<%@ page import="com.smanggin.trackingmanagement.Gallon" %>

				<%
if(actionName=='edit' || actionName=='show') { 
%>
<div class="easyui-tabs table" style="height:300px">
    
    
    
    
        
    
        
    
        
        <div title='<g:message code="gallon.productionInDetails.label" default="Production In Details" />' style="padding:10px">

            <table id="dg-productionInDetails" class="easyui-datagrid" style="height:240px"
            data-options="singleSelect:true, 
            collapsible:true, 
            onClickRow: productionInDetailsOnClickRow,
            toolbar: '#tb-productionInDetails',
            url:'/${meta(name:'app.name')}/productionInDetail/jlist?masterField.name=gallon&masterField.id=${gallonInstance?.id}'">
                <thead>
                    <tr>
                    
                        
                        <th data-options="field:'updatedBy',width:200,editor:'text'">Updated By</th>
                        

                    
                        
                        <th data-options="field:'createdBy',width:200,editor:'text'">Created By</th>
                        

                    
                        <th data-options="field:'gallonId',hidden:true">Gallon</th>
                                 
                        <th data-options="field:'productionInHeaderId',width:200,
                            formatter:function(value,row){
                                return row.productionInHeaderName;
                            },
                            editor:{
                                type:'combobox',
                                options:{
                                    valueField:'id',
                                    textField:'name',
                                    url:'/${meta(name:'app.name')}/productionInHeader/jlist',
                                    required:true,
                                }
                        }">Production In Header</th>
                                    
                        
                        <th data-options="field:'serverId',width:200,editor:'text'">Server Id</th>
                        

                    
                    </tr>
                </thead>
            </table>
        </div> 

        
    
        
        <div title='<g:message code="gallon.qCHeaders.label" default="QCH eaders" />' style="padding:10px">

            <table id="dg-qCHeaders" class="easyui-datagrid" style="height:240px"
            data-options="singleSelect:true, 
            collapsible:true, 
            onClickRow: qCHeadersOnClickRow,
            toolbar: '#tb-qCHeaders',
            url:'/${meta(name:'app.name')}/QCHeader/jlist?masterField.name=gallon&masterField.id=${gallonInstance?.id}'">
                <thead>
                    <tr>
                    
                        
                        <th data-options="field:'updatedBy',width:200,editor:'text'">Updated By</th>
                        

                    
                        
                        <th data-options="field:'createdBy',width:200,editor:'text'">Created By</th>
                        

                    
                        
                        <th data-options="field:'date',width:200,editor:'text'">Date</th>
                        

                    
                        <th data-options="field:'gallonId',hidden:true">Gallon</th>
                                 
                        
                        <th data-options="field:'number',width:200,editor:'text'">Number</th>
                        

                    
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

        
    
        
    
        
    
        
    
</div>



    

    

    

        <div id="tb-productionInDetails" style="height:auto">
            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:false" onclick="productionInDetailsAppend()">Add</a>
            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:false" onclick="productionInDetailsRemoveit()">Remove</a>
            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:false" onclick="productionInDetailsAccept()">Save</a>
            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload',plain:false" onclick="productionInDetailsRefresh()">Refresh</a>
        </div>
            
        <r:script>     
            var editIndex = undefined;
            function productionInDetailsEndEditing(){
                if (editIndex == undefined){return true}
                if ($('#dg-productionInDetails').datagrid('validateRow', editIndex)){

        
                    //productionInHeaderName
                    var ed = $('#dg-productionInDetails').datagrid('getEditor', {index:editIndex,field:'productionInHeaderId'});
                    var productionInHeaderName = $(ed.target).combobox('getText');
                    $('#dg-productionInDetails').datagrid('getRows')[editIndex]['productionInHeaderName'] = productionInHeaderName;
                    
        

                    $('#dg-productionInDetails').datagrid('endEdit', editIndex);
                    var row = $('#dg-productionInDetails').datagrid('getRows')[editIndex]
                    $.ajax({
                      type: "POST",
                      url: "/${meta(name:'app.name')}/productionInDetail/jsave",
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
            function productionInDetailsOnClickRow(index){
                if (editIndex != index){
                    if (productionInDetailsEndEditing()){
                        $('#dg-productionInDetails').datagrid('selectRow', index)
                                .datagrid('beginEdit', index);
                        editIndex = index;
                    } else {
                        $('#dg-productionInDetails').datagrid('selectRow', editIndex);
                    }
                }
            }
            function productionInDetailsAppend(){
                if (productionInDetailsEndEditing()){
                    $('#dg-productionInDetails').datagrid('appendRow',
                    {gallonId: ${gallonInstance.id? gallonInstance.id : 0} });
                    editIndex = $('#dg-productionInDetails').datagrid('getRows').length-1;
                    $('#dg-productionInDetails').datagrid('selectRow', editIndex).datagrid('beginEdit', editIndex);
                }
            }
            function productionInDetailsRemoveit(){
                if (editIndex == undefined){return}
                if (!confirm('Are you sure to delete this record?')){ return }

                var row = $('#dg-productionInDetails').datagrid('getRows')[editIndex]
                console.log(row)

                $('#dg-productionInDetails').datagrid('cancelEdit', editIndex)
                        .datagrid('deleteRow', editIndex);

                $.ajax({
                  type: "POST",
                  url: "/${meta(name:'app.name')}/productionInDetail/jdelete/" + row['id'],
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
            function productionInDetailsAccept(){
                if (productionInDetailsEndEditing()){
                    $('#dg-productionInDetails').datagrid('acceptChanges');
                }
            }

            function productionInDetailsRefresh(){
                $('#dg-productionInDetails').datagrid('reload');
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

        
                    //plantName
                    var ed = $('#dg-qCHeaders').datagrid('getEditor', {index:editIndex,field:'plantId'});
                    var plantName = $(ed.target).combobox('getText');
                    $('#dg-qCHeaders').datagrid('getRows')[editIndex]['plantName'] = plantName;
                    
        
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
                    {gallonId: ${gallonInstance.id? gallonInstance.id : 0} });
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
    

    

    

    


<%
}
%>
