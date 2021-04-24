class CreateProject < ActiveRecord::Migration[5.2]
  def change
    create_table :projects, bulk: true do |t|
      t.string :title, null: false, unique: true
      t.references :creator, index: true, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
