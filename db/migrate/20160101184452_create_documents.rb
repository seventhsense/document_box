class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :name
      t.string :file
      t.date :date
      t.string :author

      t.timestamps null: false
    end
  end
end
