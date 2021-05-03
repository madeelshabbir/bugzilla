# frozen_string_literal: true

class CreateProjectUser < ActiveRecord::Migration[5.2]
  def change
    create_table :project_users do |t|
      t.references :project, index: true, foreign_key: { on_delete: :cascade }
      t.references :user, index: true, foreign_key: { on_delete: :cascade }
      t.index %i[user_id project_id], unique: true

      t.timestamps
    end
  end
end
