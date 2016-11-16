<%@ page import="com.smanggin.trackingmanagement.Gallon" %>

				<%
if(actionName=='edit' || actionName=='show') { 
%>
<div class="easyui-tabs table" style="height:300px">
    
    
    
    
        
    
        
    
        <div title='<g:message code="gallon.codeRepalacement.label" default="Code Replacement History" />' style="padding:10px">

            <table id="dg-codeRepalacements" class="easyui-datagrid" style="height:240px"
            data-options="singleSelect:true, 
            collapsible:true, 
            
            url:'/${meta(name:'app.name')}/replaceCodeHistory/jlist?masterField.name=gallon&masterField.id=${gallonInstance?.serverId}'">
                <thead>
                    <tr>
                    
                        
                        <th data-options="field:'gallonId',hidden:true">Gallon</th>
                                 
                        <th data-options="field:'oldNumber',width:200,editor:'text'">old Number</th>

                        <th data-options="field:'newNumber',width:200,editor:'text'">newNumber</th>

                        <th data-options="field:'plantName',width:200,editor:'text'">Replace In Plant</th>                                
                        <th data-options="field:'dateCreated',width:200,editor:'text'">Replace Date</th>

                        <th data-options="field:'updatedBy',width:200,editor:'text'">Updated By</th>
    
                        <th data-options="field:'createdBy',width:200,editor:'text'">Created By</th>
                        
                        

                    
                    </tr>
                </thead>
            </table>
        </div> 


    
        
    
        
    
</div>



    

    


    

    

    


<%
}
%>
