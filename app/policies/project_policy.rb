class ProjectPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    !(@user.developer? && @record.project_users.find_by(user_id: @user.id).nil?)
  end

  def new?
    @user.manager?
  end

  def create?
    new?
  end

  def edit?
    @record.creator_id == @user.id
  end

  def update?
    edit?
  end

  def destroy?
    edit?
  end

  def creator?
    @record.creator_id == @user.id
  end

  def remove_user_access?(row_user)
    !row_user.manager? && creator?
  end
end
