<%@ page import="com.smanggin.trackingmanagement.QCQuestions" %>

				<%
if(actionName=='edit' || actionName=='show') { 
%>
<div class="easyui-tabs table" style="height:300px">
    
    
    
    
        
    
        
    
        
    
        
    
        
        <div title='<g:message code="QCQuestions.qCDetails.label" default="QCD etails" />' style="padding:10px">

            <table id="dg-qCDetails" class="easyui-datagrid" style="height:240px"
            data-options="singleSelect:true, 
            collapsible:true, 
            onClickRow: qCDetailsOnClickRow,
            toolbar: '#tb-qCDetails',
            url:'/${meta(name:'app.name')}/QCDetail/jlist?masterField.name=QCQuestions&masterField.id=${QCQuestionsInstance?.id}'">
                <thead>
                    <tr>
                    
                        
                        <th data-options="field:'updatedBy',width:200,editor:'text'">Updated By</th>
                        

                    
                        
                        <th data-options="field:'createdBy',width:200,editor:'text'">Created By</th>
                        

                    
                        <th data-options="field:'qcHeaderId',width:200,
                            formatter:function(value,row){
                                return row.qcHeaderName;
                            },
                            editor:{
                                type:'combobox',
                                options:{
                                    valueField:'id',
                                    textField:'name',
                                    url:'/${meta(name:'app.name')}/qcHeader/jlist',
                                    required:true,
                                }
                        }">Qc Header</th>
                                    
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
                                    
                        <th data-options="field:'qcQuestionsId',width:200,
                            formatter:function(value,row){
                                return row.qcQuestionsName;
                            },
                            editor:{
                                type:'combobox',
                                options:{
                                    valueField:'id',
                                    textField:'name',
                                    url:'/${meta(name:'app.name')}/qcQuestions/jlist',
                                    required:true,
                                }
                        }">Qc Questions</th>
                                    
                        
                        <th data-options="field:'results',width:200,editor:'text'">Results</th>
                        

                    
                        
                        <th data-options="field:'serverId',width:200,editor:'text'">Server Id</th>
                        

                    
                    </tr>
                </thead>
            </table>
        </div> 

        
    
        
    
        
        <div title='<g:message code="QCQuestions.qCOptions.label" default="QCO ptions" />' style="padding:10px">

            <table id="dg-qCOptions" class="easyui-datagrid" style="height:240px"
            data-options="singleSelect:true, 
            collapsible:true, 
            onClickRow: qCOptionsOnClickRow,
            toolbar: '#tb-qCOptions',
            url:'/${meta(name:'app.name')}/QCOptions/jlist?masterField.name=QCQuestions&masterField.id=${QCQuestionsInstance?.id}'">
                <thead>
                    <tr>
                    
                        
                        <th data-options="field:'description',width:200,editor:'text'">Description</th>
                        

                    
                        
                        <th data-options="field:'updatedBy',width:200,editor:'text'">Updated By</th>
                        

                    
                        
                        <th data-options="field:'createdBy',width:200,editor:'text'">Created By</th>
                        

                    
                        <th data-options="field:'qCMasterId',width:200,
                            formatter:function(value,row){
                                return row.qCMasterName;
                            },
                            editor:{
                                type:'combobox',
                                options:{
                                    valueField:'id',
                                    textField:'name',
                                    url:'/${meta(name:'app.name')}/qCMaster/jlist',
                                    required:true,
                                }
                        }">QCM aster</th>
                                    
                        <th data-options="field:'qCQuestionsId',width:200,
                            formatter:function(value,row){
                                return row.qCQuestionsName;
                            },
                            editor:{
                                type:'combobox',
                                options:{
                                    valueField:'id',
                                    textField:'name',
                                    url:'/${meta(name:'app.name')}/qCQuestions/jlist',
                                    required:true,
                                }
                        }">QCQ uestions</th>
                                    
                        
                        <th data-options="field:'serverId',width:200,editor:'text'">Server Id</th>
                        

                    
                    </tr>
                </thead>
            </table>
        </div> 

        
    
        
    
        
    
        
    
</div>



    

    

    

    

    

        <div id="tb-qCDetails" style="height:auto">
            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:false" onclick="qCDetailsAppend()">Add</a>
            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:false" onclick="qCDetailsRemoveit()">Remove</a>
            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:false" onclick="qCDetailsAccept()">Save</a>
            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload',plain:false" onclick="qCDetailsRefresh()">Refresh</a>
        </div>
            
        <r:script>     
            var editIndex = undefined;
            function qCDetailsEndEditing(){
                if (editIndex == undefined){return true}
                if ($('#dg-qCDetails').datagrid('validateRow', editIndex)){

        
                    //qcHeaderName
                    var ed = $('#dg-qCDetails').datagrid('getEditor', {index:editIndex,field:'qcHeaderId'});
                    var qcHeaderName = $(ed.target).combobox('getText');
                    $('#dg-qCDetails').datagrid('getRows')[editIndex]['qcHeaderName'] = qcHeaderName;
                    
        
                    //qcMasterName
                    var ed = $('#dg-qCDetails').datagrid('getEditor', {index:editIndex,field:'qcMasterId'});
                    var qcMasterName = $(ed.target).combobox('getText');
                    $('#dg-qCDetails').datagrid('getRows')[editIndex]['qcMasterName'] = qcMasterName;
                    
        
                    //qcQuestionsName
                    var ed = $('#dg-qCDetails').datagrid('getEditor', {index:editIndex,field:'qcQuestionsId'});
                    var qcQuestionsName = $(ed.target).combobox('getText');
                    $('#dg-qCDetails').datagrid('getRows')[editIndex]['qcQuestionsName'] = qcQuestionsName;
                    
        

                    $('#dg-qCDetails').datagrid('endEdit', editIndex);
                    var row = $('#dg-qCDetails').datagrid('getRows')[editIndex]
                    $.ajax({
                      type: "POST",
                      url: "/${meta(name:'app.name')}/QCDetail/jsave",
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
            function qCDetailsOnClickRow(index){
                if (editIndex != index){
                    if (qCDetailsEndEditing()){
                        $('#dg-qCDetails').datagrid('selectRow', index)
                                .datagrid('beginEdit', index);
                        editIndex = index;
                    } else {
                        $('#dg-qCDetails').datagrid('selectRow', editIndex);
                    }
                }
            }
            function qCDetailsAppend(){
                if (qCDetailsEndEditing()){
                    $('#dg-qCDetails').datagrid('appendRow',
                    {QCQuestionsId: ${QCQuestionsInstance.id? QCQuestionsInstance.id : 0} });
                    editIndex = $('#dg-qCDetails').datagrid('getRows').length-1;
                    $('#dg-qCDetails').datagrid('selectRow', editIndex).datagrid('beginEdit', editIndex);
                }
            }
            function qCDetailsRemoveit(){
                if (editIndex == undefined){return}
                if (!confirm('Are you sure to delete this record?')){ return }

                var row = $('#dg-qCDetails').datagrid('getRows')[editIndex]
                console.log(row)

                $('#dg-qCDetails').datagrid('cancelEdit', editIndex)
                        .datagrid('deleteRow', editIndex);

                $.ajax({
                  type: "POST",
                  url: "/${meta(name:'app.name')}/QCDetail/jdelete/" + row['id'],
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
            function qCDetailsAccept(){
                if (qCDetailsEndEditing()){
                    $('#dg-qCDetails').datagrid('acceptChanges');
                }
            }

            function qCDetailsRefresh(){
                $('#dg-qCDetails').datagrid('reload');
                editIndex = undefined;
            }
        </r:script>  
    

    

    

        <div id="tb-qCOptions" style="height:auto">
            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:false" onclick="qCOptionsAppend()">Add</a>
            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:false" onclick="qCOptionsRemoveit()">Remove</a>
            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:false" onclick="qCOptionsAccept()">Save</a>
            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload',plain:false" onclick="qCOptionsRefresh()">Refresh</a>
        </div>
            
        <r:script>     
            var editIndex = undefined;
            function qCOptionsEndEditing(){
                if (editIndex == undefined){return true}
                if ($('#dg-qCOptions').datagrid('validateRow', editIndex)){

        
                    //qCMasterName
                    var ed = $('#dg-qCOptions').datagrid('getEditor', {index:editIndex,field:'qCMasterId'});
                    var qCMasterName = $(ed.target).combobox('getText');
                    $('#dg-qCOptions').datagrid('getRows')[editIndex]['qCMasterName'] = qCMasterName;
                    
        
                    //qCQuestionsName
                    var ed = $('#dg-qCOptions').datagrid('getEditor', {index:editIndex,field:'qCQuestionsId'});
                    var qCQuestionsName = $(ed.target).combobox('getText');
                    $('#dg-qCOptions').datagrid('getRows')[editIndex]['qCQuestionsName'] = qCQuestionsName;
                    
        

                    $('#dg-qCOptions').datagrid('endEdit', editIndex);
                    var row = $('#dg-qCOptions').datagrid('getRows')[editIndex]
                    $.ajax({
                      type: "POST",
                      url: "/${meta(name:'app.name')}/QCOptions/jsave",
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
            function qCOptionsOnClickRow(index){
                if (editIndex != index){
                    if (qCOptionsEndEditing()){
                        $('#dg-qCOptions').datagrid('selectRow', index)
                                .datagrid('beginEdit', index);
                        editIndex = index;
                    } else {
                        $('#dg-qCOptions').datagrid('selectRow', editIndex);
                    }
                }
            }
            function qCOptionsAppend(){
                if (qCOptionsEndEditing()){
                    $('#dg-qCOptions').datagrid('appendRow',
                    {QCQuestionsId: ${QCQuestionsInstance.id? QCQuestionsInstance.id : 0} });
                    editIndex = $('#dg-qCOptions').datagrid('getRows').length-1;
                    $('#dg-qCOptions').datagrid('selectRow', editIndex).datagrid('beginEdit', editIndex);
                }
            }
            function qCOptionsRemoveit(){
                if (editIndex == undefined){return}
                if (!confirm('Are you sure to delete this record?')){ return }

                var row = $('#dg-qCOptions').datagrid('getRows')[editIndex]
                console.log(row)

                $('#dg-qCOptions').datagrid('cancelEdit', editIndex)
                        .datagrid('deleteRow', editIndex);

                $.ajax({
                  type: "POST",
                  url: "/${meta(name:'app.name')}/QCOptions/jdelete/" + row['id'],
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
            function qCOptionsAccept(){
                if (qCOptionsEndEditing()){
                    $('#dg-qCOptions').datagrid('acceptChanges');
                }
            }

            function qCOptionsRefresh(){
                $('#dg-qCOptions').datagrid('reload');
                editIndex = undefined;
            }
        </r:script>  
    

    

    

    


<%
}
%>
