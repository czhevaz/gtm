<%@ page import="com.smanggin.trackingmanagement.ProductionInHeader" %>

				<%
if(actionName=='edit' || actionName=='show') { 
%>
<div class="easyui-tabs table" style="height:300px">
    
    
    
    
        
    
        
    
        
    
        
    
        
        <div title='<g:message code="productionInHeader.productionInDetails.label" default="Production In Details" />' style="padding:10px">

            <table id="dg-productionInDetails" class="easyui-datagrid" style="height:240px"
            data-options="singleSelect:true, 
            collapsible:true, 
            onClickRow: productionInDetailsOnClickRow,
            toolbar: '#tb-productionInDetails',
            url:'/${meta(name:'app.name')}/productionInDetail/jlist?masterField.name=productionInHeader&masterField.id=${productionInHeaderInstance?.id}'">
                <thead>
                    <tr>
                    
                        
                        <th data-options="field:'updatedBy',width:200,editor:'text'">Updated By</th>
                        

                    
                        
                        <th data-options="field:'createdBy',width:200,editor:'text'">Created By</th>
                        

                    
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
                                    
                        <th data-options="field:'productionInHeaderId',hidden:true">Production In Header</th>
                                 
                        
                        <th data-options="field:'serverId',width:200,editor:'text'">Server Id</th>
                        

                    
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

        
                    //gallonName
                    var ed = $('#dg-productionInDetails').datagrid('getEditor', {index:editIndex,field:'gallonId'});
                    var gallonName = $(ed.target).combobox('getText');
                    $('#dg-productionInDetails').datagrid('getRows')[editIndex]['gallonName'] = gallonName;
                    
        

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
                    {productionInHeaderId: ${productionInHeaderInstance.id? productionInHeaderInstance.id : 0} });
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
    

    

    

    

    


<%
}
%>
