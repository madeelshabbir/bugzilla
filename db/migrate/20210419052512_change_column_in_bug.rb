class ChangeColumnInBug < ActiveRecord::Migration[5.2]
  def change
    change_column :bugs, :status, :integer, default: 0
  end
end
