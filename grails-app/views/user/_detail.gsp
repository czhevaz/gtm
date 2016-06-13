<%@ page import="com.smanggin.trackingmanagement.User" %>

				<%
if(actionName=='edit' || actionName=='show') { 
%>
<div class="easyui-tabs table" style="height:300px">

        
        <div title='<g:message code="user.userPlants.label" default="User Plants" />' style="padding:10px">

            <table id="dg-userPlants" class="easyui-datagrid" style="height:240px"
            data-options="singleSelect:true, 
            collapsible:true, 
            onClickRow: userPlantsOnClickRow,
            toolbar: '#tb-userPlants',
            url:'/${meta(name:'app.name')}/userPlants/jlist?masterField.name=user&masterField.id=${userInstance?.serverId}'">
                <thead>
                    <tr>            
                        <th data-options="field:'plantId',width:200,
                            formatter:function(value,row){
                                return row.plantName;
                            },
                            editor:{
                                type:'combobox',
                                options:{
                                    valueField:'serverId',
                                    textField:'name',
                                    url:'/${meta(name:'app.name')}/plant/jlist',
                                    required:true,
                                }
                        }">Plant</th>
                                    
                        <th data-options="field:'isDefault',align:'right', width:100,editor:{type:'checkbox',options:{on:'1',off:'0'}}">isDefault</th>
                        
                        <th data-options="field:'userId',hidden:true">User</th>


                                 
                    </tr>
                </thead>
            </table>
        </div> 

        
    
</div>



    

    

    

    

    

    

    

    

    

    

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

        
                    //plantName
                    var ed = $('#dg-userPlants').datagrid('getEditor', {index:editIndex,field:'plantId'});
                    var plantName = $(ed.target).combobox('getText');
                    $('#dg-userPlants').datagrid('getRows')[editIndex]['plantName'] = plantName;
                    
        

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
                    {userId: '${userInstance.serverId? userInstance.serverId : 0}' });
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
    


<%
}
%>
