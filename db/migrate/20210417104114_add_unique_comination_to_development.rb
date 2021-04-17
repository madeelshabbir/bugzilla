class AddUniqueCominationToDevelopment < ActiveRecord::Migration[5.2]
  def change
    add_index :developments, %i[user_id project_id], unique: true
  end
end
