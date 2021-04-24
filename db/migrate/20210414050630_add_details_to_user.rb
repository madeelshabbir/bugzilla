class AddDetailsToUser < ActiveRecord::Migration[5.2]
  def change
    change_table :users, bulk: true do |t|
      t.string :name, null: false
      t.integer :user_type, null: false
    end
  end
end
