class CreateBinders < ActiveRecord::Migration
  def change
    create_table :binders do |t|
      t.string :title
      t.text :memo

      t.timestamps null: false
    end
  end
end
