class CreateBugs < ActiveRecord::Migration[5.2]
  def change
    create_table :bugs do |t|
      t.string :title
      t.text :description
      t.date :deadline
      t.string :screenshot
      t.integer :type
      t.integer :status

      t.timestamps
    end
  end
end
