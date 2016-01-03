class AddIndexToDocument < ActiveRecord::Migration
  def change
    add_index :documents, :name
    add_index :documents, :binder_id
    add_index :documents, :label
    add_index :documents, :date
    add_index :documents, :content
    add_index :documents, :author
  end
end
