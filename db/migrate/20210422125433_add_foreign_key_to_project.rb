class AddForeignKeyToProject < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :projects, :users, column: :creator_id
  end
end
