class DocumentIndexer
  def initialize
    @documents = Groonga['Documents']
  end

  def add(document)
    attributes = document.attributes
    id = attributes.delete('id')
    attributes.delete('file')
    attributes.delete('binder_id')
    @documents.add(id, attributes)
  end

  def remove(document)
    @documents[document.id].delete
  end
end
