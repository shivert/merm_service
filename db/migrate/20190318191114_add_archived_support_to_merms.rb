class AddArchivedSupportToMerms < ActiveRecord::Migration[5.1]
  def change
    add_column :merms, :expired, :boolean, null: false, default: false
    add_column :merms, :expiry_date, :datetime
  end
end
