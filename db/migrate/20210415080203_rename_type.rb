class RenameType < ActiveRecord::Migration[5.2]
  def change
    rename_column :bugs, :type, :_type
  end
end
