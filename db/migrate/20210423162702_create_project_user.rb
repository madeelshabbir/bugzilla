class CreateProjectUser < ActiveRecord::Migration[5.2]
  def change
    create_table :project_users do |t|
      t.references :project, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.index %i[user_id project_id], unique: true

      t.timestamps
    end
  end
end
