class Document < ActiveRecord::Base
  before_validation :default_name
  mount_uploader :file, FileUploader
  # default_scope { order(updated_at: :desc) } 

  validates :name, :file, :presence => true

  def default_name
    self.name ||= File.basename(file.filename, '/*') if file
  end
end
