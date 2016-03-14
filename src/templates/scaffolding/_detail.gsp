<%=packageName%>
<% import grails.persistence.Event %>
				<%= "<%" %>
if(actionName=='edit' || actionName=='show') { 
<%= "%" %><%= ">" %>
<div class="easyui-tabs table" style="height:300px">
    
    <% excludedProps = Event.allEvents.toList() << 'version' << 'dateCreated' << 'lastUpdated'
	persistentPropNames = domainClass.persistentProperties*.name
	boolean hasHibernate = pluginManager?.hasGrailsPlugin('hibernate')
	if (hasHibernate && org.codehaus.groovy.grails.orm.hibernate.cfg.GrailsDomainBinder.getMapping(domainClass)?.identity?.generator == 'assigned') {
		persistentPropNames << domainClass.identifier.name
	}
	props = domainClass.properties.findAll { persistentPropNames.contains(it.name) && !excludedProps.contains(it.name) }
	%>
    <% propsx = null %>
    <% props.each { p -> %>
        <%  
        if (p.oneToMany || p.manyToMany) { 
            def cls = p.referencedDomainClass 
            def controllerName = cls.propertyName
        %>
        <div title='<g:message code="${domainClass.propertyName}.${p.name}.label" default="${p.naturalName}" />' style="padding:10px">

            <table id="dg-${p.name}" class="easyui-datagrid" style="height:240px"
            data-options="singleSelect:true, 
            collapsible:true, 
            onClickRow: ${p.name}OnClickRow,
            toolbar: '#tb-${p.name}',
            url:'/\${meta(name:'app.name')}/${controllerName}/jlist?masterField.name=${domainClass.propertyName}&masterField.id=\${${domainClass.propertyName}Instance?.id}'">
                <thead>
                    <tr>
                    <%  excludedPropsx = Event.allEvents.toList() << 'id' << 'version' << 'dateCreated' << 'lastUpdated'
                        allowedNamesx = cls.persistentProperties*.name 
                        propsx = cls.properties.findAll { allowedNamesx.contains(it.name) && !excludedPropsx.contains(it.name) && !Collection.isAssignableFrom(it.type) }
                        Collections.sort(propsx, comparator.constructors[0].newInstance([cls] as Object[]))
                        propsx.eachWithIndex { px, i ->
                            if (i < 15) {
                                if (px.isAssociation() )  { 
                                    if ((px.name!=domainClass.propertyName)) { %>
                        <th data-options="field:'${px.name}Id',width:200,
                            formatter:function(value,row){
                                return row.${px.name}Name;
                            },
                            editor:{
                                type:'combobox',
                                options:{
                                    valueField:'id',
                                    textField:'name',
                                    url:'/\${meta(name:'app.name')}/${px.name}/jlist',
                                    required:true,
                                }
                        }">${px.naturalName}</th>
                                    <% } else { %>
                        <th data-options="field:'${px.name}Id',hidden:true">${px.naturalName}</th>
                                 <% }
                                } else { %>
                        <% if (px.type && Number.isAssignableFrom(px.type) || (px.type?.isPrimitive() && px.type != boolean)) { %>
                        <th data-options="field:'${px.name}',align:'right',formatter:formatNumber,  width:100,editor:{type:'numberbox',options:{precision:2}}">${px.naturalName}</th>
                        <% } else if (px.type == Boolean || px.type == boolean) { %>
                        <th data-options="field:'${px.name}',align:'right', width:100,editor:{type:'checkbox',options:{on:'1',off:'0'}}">${px.naturalName}</th>
                        <% } else { %>
                        <th data-options="field:'${px.name}',width:200,editor:'text'">${px.naturalName}</th>
                        <% } %>

                    <%  }   }   } %>
                    </tr>
                </thead>
            </table>
        </div> 

        <%  } %>
    <%  } %>
</div>


<% 
//domainClass = nama class ini
//props adalah property dari class ini
props.each { p -> %>
    <%  
    if (p.oneToMany || p.manyToMany) { 
        def cls = p.referencedDomainClass 
        def controllerName = cls.propertyName
    %>

        <div id="tb-${p.name}" style="height:auto">
            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:false" onclick="${p.name}Append()">Add</a>
            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:false" onclick="${p.name}Removeit()">Remove</a>
            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:false" onclick="${p.name}Accept()">Save</a>
            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload',plain:false" onclick="${p.name}Refresh()">Refresh</a>
        </div>
            
        <r:script>     
            var editIndex = undefined;
            function ${p.name}EndEditing(){
                if (editIndex == undefined){return true}
                if (\$('#dg-${p.name}').datagrid('validateRow', editIndex)){

        <% 
excludedPropsx = Event.allEvents.toList() << 'id' << 'version' << 'dateCreated' << 'lastUpdated'
allowedNamesx = cls.persistentProperties*.name 
propsx = cls.properties.findAll { allowedNamesx.contains(it.name) && !excludedPropsx.contains(it.name) && !Collection.isAssignableFrom(it.type) }
Collections.sort(propsx, comparator.constructors[0].newInstance([cls] as Object[]))

        //propsx adalah property nya class yang jadi detail dari class ini
        propsx.eachWithIndex { px, i ->
            if (i < 7) {
                if (px.isAssociation() )  { 
                    if ((px.name!=domainClass.propertyName)){ %>
                    //${px.name}Name
                    var ed = \$('#dg-${p.name}').datagrid('getEditor', {index:editIndex,field:'${px.name}Id'});
                    var ${px.name}Name = \$(ed.target).combobox('getText');
                    \$('#dg-${p.name}').datagrid('getRows')[editIndex]['${px.name}Name'] = ${px.name}Name;
                    
        <% } } } } %>

                    \$('#dg-${p.name}').datagrid('endEdit', editIndex);
                    var row = \$('#dg-${p.name}').datagrid('getRows')[editIndex]
                    \$.ajax({
                      type: "POST",
                      url: "/\${meta(name:'app.name')}/${controllerName}/jsave",
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
            function ${p.name}OnClickRow(index){
                if (editIndex != index){
                    if (${p.name}EndEditing()){
                        \$('#dg-${p.name}').datagrid('selectRow', index)
                                .datagrid('beginEdit', index);
                        editIndex = index;
                    } else {
                        \$('#dg-${p.name}').datagrid('selectRow', editIndex);
                    }
                }
            }
            function ${p.name}Append(){
                if (${p.name}EndEditing()){
                    \$('#dg-${p.name}').datagrid('appendRow',
                    {${domainClass.propertyName}Id: \${${domainClass.propertyName}Instance.id? ${domainClass.propertyName}Instance.id : 0} });
                    editIndex = \$('#dg-${p.name}').datagrid('getRows').length-1;
                    \$('#dg-${p.name}').datagrid('selectRow', editIndex).datagrid('beginEdit', editIndex);
                }
            }
            function ${p.name}Removeit(){
                if (editIndex == undefined){return}
                if (!confirm('Are you sure to delete this record?')){ return }

                var row = \$('#dg-${p.name}').datagrid('getRows')[editIndex]
                console.log(row)

                \$('#dg-${p.name}').datagrid('cancelEdit', editIndex)
                        .datagrid('deleteRow', editIndex);

                \$.ajax({
                  type: "POST",
                  url: "/\${meta(name:'app.name')}/${controllerName}/jdelete/" + row['id'],
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
            function ${p.name}Accept(){
                if (${p.name}EndEditing()){
                    \$('#dg-${p.name}').datagrid('acceptChanges');
                }
            }

            function ${p.name}Refresh(){
                \$('#dg-${p.name}').datagrid('reload');
                editIndex = undefined;
            }
        </r:script>  
    <% } %>
<% } %>

<%= "<%" %>
}
<%= "%" %><%= ">" %>
