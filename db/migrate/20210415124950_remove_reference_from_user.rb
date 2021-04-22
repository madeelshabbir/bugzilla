class RemoveReferenceFromUser < ActiveRecord::Migration[5.2]
  def change
    remove_reference :users, :project, foreign_key: true
  end
end
