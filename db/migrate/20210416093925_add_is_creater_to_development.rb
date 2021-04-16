class AddIsCreaterToDevelopment < ActiveRecord::Migration[5.2]
  def change
    add_column :developments, :is_creater, :boolean, default: false
  end
end
