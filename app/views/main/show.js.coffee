$('#dialog')
  .html("<%=j render partial: 'dialog', locals: {document: @document} %>")
  .dialog
    width: 600
