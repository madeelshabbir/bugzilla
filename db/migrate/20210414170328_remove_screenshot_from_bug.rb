class RemoveScreenshotFromBug < ActiveRecord::Migration[5.2]
  def change
    remove_column :bugs, :screenshot, :string
  end
end
