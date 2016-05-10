<%@ page import="com.smanggin.trackingmanagement.Item" %>

				<%
if(actionName=='edit' || actionName=='show') { 
%>
<div class="easyui-tabs table" style="height:300px">
    
    
    
    
        
    
        
        <div title='<g:message code="item.gallons.label" default="Gallons" />' style="padding:10px">

            <table id="dg-gallons" class="easyui-datagrid" style="height:240px"
            data-options="singleSelect:true, 
            collapsible:true, 
            onClickRow: gallonsOnClickRow,
            toolbar: '#tb-gallons',
            url:'/${meta(name:'app.name')}/gallon/jlist?masterField.name=item&masterField.id=${itemInstance?.id}'">
                <thead>
                    <tr>
                    
                        
                        <th data-options="field:'code',width:200,editor:'text'">Code</th>
                        

                    
                        
                        <th data-options="field:'writeOff',align:'right', width:100,editor:{type:'checkbox',options:{on:'1',off:'0'}}">Write Off</th>
                        

                    
                        
                        <th data-options="field:'updatedBy',width:200,editor:'text'">Updated By</th>
                        

                    
                        
                        <th data-options="field:'createdBy',width:200,editor:'text'">Created By</th>
                        

                    
                        <th data-options="field:'itemId',hidden:true">Item</th>
                                 
                        
                        <th data-options="field:'serverId',width:200,editor:'text'">Server Id</th>
                        

                    
                    </tr>
                </thead>
            </table>
        </div> 

        
    
        
    
</div>



    

    

        <div id="tb-gallons" style="height:auto">
            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:false" onclick="gallonsAppend()">Add</a>
            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:false" onclick="gallonsRemoveit()">Remove</a>
            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:false" onclick="gallonsAccept()">Save</a>
            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload',plain:false" onclick="gallonsRefresh()">Refresh</a>
        </div>
            
        <r:script>     
            var editIndex = undefined;
            function gallonsEndEditing(){
                if (editIndex == undefined){return true}
                if ($('#dg-gallons').datagrid('validateRow', editIndex)){

        

                    $('#dg-gallons').datagrid('endEdit', editIndex);
                    var row = $('#dg-gallons').datagrid('getRows')[editIndex]
                    $.ajax({
                      type: "POST",
                      url: "/${meta(name:'app.name')}/gallon/jsave",
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
            function gallonsOnClickRow(index){
                if (editIndex != index){
                    if (gallonsEndEditing()){
                        $('#dg-gallons').datagrid('selectRow', index)
                                .datagrid('beginEdit', index);
                        editIndex = index;
                    } else {
                        $('#dg-gallons').datagrid('selectRow', editIndex);
                    }
                }
            }
            function gallonsAppend(){
                if (gallonsEndEditing()){
                    $('#dg-gallons').datagrid('appendRow',
                    {itemId: ${itemInstance.id? itemInstance.id : 0} });
                    editIndex = $('#dg-gallons').datagrid('getRows').length-1;
                    $('#dg-gallons').datagrid('selectRow', editIndex).datagrid('beginEdit', editIndex);
                }
            }
            function gallonsRemoveit(){
                if (editIndex == undefined){return}
                if (!confirm('Are you sure to delete this record?')){ return }

                var row = $('#dg-gallons').datagrid('getRows')[editIndex]
                console.log(row)

                $('#dg-gallons').datagrid('cancelEdit', editIndex)
                        .datagrid('deleteRow', editIndex);

                $.ajax({
                  type: "POST",
                  url: "/${meta(name:'app.name')}/gallon/jdelete/" + row['id'],
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
            function gallonsAccept(){
                if (gallonsEndEditing()){
                    $('#dg-gallons').datagrid('acceptChanges');
                }
            }

            function gallonsRefresh(){
                $('#dg-gallons').datagrid('reload');
                editIndex = undefined;
            }
        </r:script>  
    

    


<%
}
%>
