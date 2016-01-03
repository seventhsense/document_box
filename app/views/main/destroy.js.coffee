alert '<%=j @document.name %> is deleted !'
$('#dialog').dialog('close')
$('#files').dataTable().api().ajax.reload()
