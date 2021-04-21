class AddCreatorIdToBug < ActiveRecord::Migration[5.2]
  def change
    add_column :bugs, :creator_id, :bigint
    add_foreign_key :bugs, :users, column: :creator_id
  end
end
