class CreateMerms < ActiveRecord::Migration[5.1]
  def change
    create_table :merms do |t|
      t.string :name
      t.string :resource_name
      t.boolean :favorite, null: false, default: false
      t.string :resource_url
      t.integer :owner_id
      t.integer :category_id
      t.string :content_type
      t.string :source
      t.string :description
      t.string :captured_text
      t.datetime :last_accessed

      t.timestamps
    end
  end
end
