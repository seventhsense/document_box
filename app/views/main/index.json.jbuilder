json.sEcho @sEcho
json.iTotalRecords Document.count
json.iTotalDisplayRecords @display_documents.count
json.aaData @documents do |document|
  json.array! [ 
               editable(document, :label),
               editable(document, :name),
               editable(document, :author),
               editable(document, :date, type: :date),
               editable(document, :content, type: :textarea),
               thumb_link(document.file_url(:thumb), document.file_url),
               "#{link_to 'Detail', document_path(document), remote: true}"
  ]
end
