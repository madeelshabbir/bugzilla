class UpdateForeignKeys < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :bugs, :users, column: :creator_id, on_delete: :cascade
    add_foreign_key :projects, :users, column: :creator_id, on_delete: :cascade
    add_foreign_key :project_users, :users, column: :user_id, on_delete: :cascade
    add_foreign_key :project_users, :projects, column: :project_id, on_delete: :cascade
  end
end
