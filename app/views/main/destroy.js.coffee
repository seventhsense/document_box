Materialize.toast '<%=j @document.name %> is deleted !', 4000
$('#dialog').dialog('close')
$('#files').dataTable().api().ajax.reload()
