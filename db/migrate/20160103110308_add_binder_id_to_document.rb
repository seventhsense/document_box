class AddBinderIdToDocument < ActiveRecord::Migration
  def change
    add_column :documents, :binder_id, :int
  end
end
