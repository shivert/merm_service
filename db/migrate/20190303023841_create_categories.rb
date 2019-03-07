class CreateCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :categories do |t|
      t.integer :owner_id, null: false
      t.string :name, null: false
      t.integer :rank, null: false
      t.boolean :custom, null: false, default: true

      t.timestamps
    end
  end
end
