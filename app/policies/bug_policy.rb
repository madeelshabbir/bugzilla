class BugPolicy < ApplicationPolicy
  def index?
    !(@record.project.developments.find_by(user_id: @user.id).nil? && @user.developer?)
  end

  def show?
    !(@record.project.developments.find_by(user_id: @user.id).nil? && @user.developer?)
  end

  def create?
    current_user.qa?
  end

  def new?
    create?
  end

  def update?
    @user.developer? && (@record.user_id == @user.id || @record.user.qa?)
  end

  def destroy?
    current_user.qa?
  end
end
