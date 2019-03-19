class AddDeletedAtToMerms < ActiveRecord::Migration[5.1]
  def change
    add_column :merms, :deleted_at, :datetime
    add_index :merms, :deleted_at
  end
end
