class AddCreatorIdToProject < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :creator_id, :bigint
    add_foreign_key :projects, :users, column: :creator_id
  end
end
