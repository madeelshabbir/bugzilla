# frozen_string_literal: true

class CreateProject < ActiveRecord::Migration[5.2]
  def change
    create_table :projects, bulk: true do |t|
      t.string :title, null: false
      t.references :creator, index: true, foreign_key: { to_table: :users, on_delete: :cascade }
      t.index :title, unique: true

      t.timestamps
    end
  end
end
