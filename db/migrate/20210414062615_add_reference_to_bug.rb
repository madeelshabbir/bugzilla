class AddReferenceToBug < ActiveRecord::Migration[5.2]
  def change
    add_reference :bugs, :user, foreign_key: true
    add_reference :bugs, :project, foreign_key: true
  end
end
