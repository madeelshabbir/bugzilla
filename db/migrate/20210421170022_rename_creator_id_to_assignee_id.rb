class RenameCreatorIdToAssigneeId < ActiveRecord::Migration[5.2]
  def change
    rename_column :bugs, :creator_id, :assignee_id
  end
end
