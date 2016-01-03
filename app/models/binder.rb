class Binder < ActiveRecord::Base
  has_many :documents
  validates :title, :presence => true
end
