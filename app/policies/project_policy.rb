class ProjectPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    !@user.developer? || @record.users.exists?(@user.id)
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
    edit?
  end

  def remove_user_view?(row_user)
    !row_user.manager? && creator?
  end

  class Scope < Scope
    def resolve
      if @user.developer?
        @user.projects
      else
        scope.all
      end
    end
  end
end
