class ProjectUserPolicy < ApplicationPolicy
  def add_user?
    @record.project.creator_id == @user.id
  end

  def remove_user?
    add_user?
  end
end
