class BugPolicy < ApplicationPolicy
  def index?
    !(@user.developer? && @record.project.project_users.find_by(user_id: @user.id).nil?)
  end

  def show?
    index?
  end

  def new?
    @user.qa?
  end

  def create?
    new?
  end

  def update?
    @user.developer? && (@record.user_id == @user.id || @record.user.qa?)
  end

  def destroy?
    new?
  end

  def add_user_access?
    @user.developer? && (@record.assignee_id == @user.id || @record.assignee.nil?)
  end
end
