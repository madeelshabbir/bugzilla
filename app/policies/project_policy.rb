class ProjectPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    !(@record.developments.find_by(user_id: @user.id).nil? && @user.developer?)
  end

  def create?
    @user.manager?
  end

  def new?
    create?
  end

  def update?
    @record.developments.find_by(is_creater: true).user_id == @user.id
  end

  def edit?
    update?
  end

  def destroy?
    @record.developments.find_by(is_creater: true).user_id == @user.id
  end
end
