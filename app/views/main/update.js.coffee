Materialize.toast '<%=j @document.name %> is updated!', 2000
$('#dialog').dialog('close')
$('#files').dataTable().api().ajax.reload()
