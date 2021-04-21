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
    @record.creator_id == @user.id
  end
end
