class CreateBug < ActiveRecord::Migration[5.2]
  def change
    create_table :bugs do |t|
      t.string :title, null: false
      t.text :description
      t.date :deadline, null: false
      t.integer :status, null: false, default: 0
      t.integer :bug_type, null: false
      t.references :creator, index: true, foreign_key: { to_table: :users }
      t.references :assignee, index: true, foreign_key: { to_table: :users }
      t.references :project, index: true, foreign_key: true
      t.index %i[title project_id], unique: true

      t.timestamps
    end
  end
end
