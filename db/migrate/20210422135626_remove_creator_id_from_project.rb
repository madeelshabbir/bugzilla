class RemoveCreatorIdFromProject < ActiveRecord::Migration[5.2]
  def change
    remove_foreign_key :projects, column: :creator_id
    remove_column :projects, :creator_id, :bigint
  end
end
