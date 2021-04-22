class RenameDevelopmentsToProjectUsers < ActiveRecord::Migration[5.2]
  def change
    rename_table :developments, :project_users
  end
end
