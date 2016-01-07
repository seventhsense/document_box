class DocumentSearcher
  def initialize(query)
    @query = query
    @documents = Groonga['Documents']
  end
 
  def search
    matched_documents = @documents.select do |record|
      match_target = record.match_target do |match_record|
        (match_record.name * 5) | (match_record.author * 5) | (match_record.label * 5) | (match_record.content)| (match_record.body)
      end
      words.collect do |word|
        match_target =~ word
      end
    end
    documents_ids = matched_documents.sort(['_score']).collect do |matched_document|
      matched_document._key
    end
    Document.where(id: documents_ids)
  end
 
  private
  def words
    @query.split(/s+/)
  end
end
