class AddLabelToDocument < ActiveRecord::Migration
  def change
    add_column :documents, :label, :string
  end
end
