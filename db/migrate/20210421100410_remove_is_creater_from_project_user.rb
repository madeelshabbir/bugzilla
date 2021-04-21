class RemoveIsCreaterFromProjectUser < ActiveRecord::Migration[5.2]
  def change
    remove_column :project_users, :is_creater, :integer
  end
end
