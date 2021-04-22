class RemoveReferenceFromBug < ActiveRecord::Migration[5.2]
  def change
    remove_reference :bugs, :project, foreign_key: true
    remove_reference :project_users, :user, foreign_key: true
    remove_reference :project_users, :project, foreign_key: true
    add_reference :bugs, :project, foreign_key: true, on_delete: :cascade
    add_reference :project_users, :user, foreign_key: true, on_delete: :cascade
    add_reference :project_users, :project, foreign_key: true, on_delete: :cascade
  end
end
