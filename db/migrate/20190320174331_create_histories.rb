class CreateHistories < ActiveRecord::Migration[5.1]
  def change
    create_table :histories do |t|
      t.integer :merm_id
      t.string :name
      t.string :url
      t.datetime :visit_time

      t.timestamps
    end
  end
end
