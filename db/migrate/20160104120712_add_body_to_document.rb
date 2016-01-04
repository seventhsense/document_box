class AddBodyToDocument < ActiveRecord::Migration
  def change
    add_column :documents, :body, :text
    add_index :documents, :body
  end
end
