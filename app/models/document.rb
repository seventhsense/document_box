class Document < ActiveRecord::Base
  belongs_to :binder
  before_validation :default_name
  after_save :add_index
  after_destroy :remove_index
  mount_uploader :file, FileUploader
  # default_scope { order(updated_at: :desc) } 

  validates :name, :file, :presence => true

  def default_name
    self.name ||= File.basename(file.filename, '/*') if file
  end

  def self.filtered_by_binder(binder_id)
    if binder_id.nil?
      all
    else
      where(binder_id: binder_id)
    end
  end

  def self.search(query)
    searcher = DocumentSearcher.new(query)
    searcher.search
  end

  def add_index
    indexer = DocumentIndexer.new
    indexer.add(self)
  end

  def remove_index
    indexer = DocumentIndexer.new
    indexer.remove(self)
  end
end
