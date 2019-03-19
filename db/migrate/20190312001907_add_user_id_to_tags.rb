class AddUserIdToTags < ActiveRecord::Migration[5.1]
  def change
    add_column :tags, :owner_id, :integer
    add_index :tags, :owner_id
  end
end
