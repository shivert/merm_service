class CreateShares < ActiveRecord::Migration[5.1]
  def change
    create_table :shares do |t|
      t.integer :merm_id
      t.integer :sharer_id
      t.integer :shared_with_id
      t.boolean :read, null: false, default: false
      t.timestamps
    end
  end
end
