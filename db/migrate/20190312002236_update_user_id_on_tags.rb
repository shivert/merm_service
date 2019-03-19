class UpdateUserIdOnTags < ActiveRecord::Migration[5.1]
  def change
    Tag.all.each do |tag|
      tag.owner_id = tag.merm.owner_id
      tag.save
    end
  end
end
