# frozen_string_literal: true

class BugPolicy < ApplicationPolicy
  def index?
    @user.manager? || @user.qa? || @record.project.users.exists?(@user.id)
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
    @user.developer? && (@record.assignee.nil? || @record.assignee_id == @user.id)
  end

  def destroy?
    new?
  end

  class Scope < Scope
    def resolve
      if @user.developer?
        scope.assigned_to(@user.id)
      elsif @user.qa?
        scope.created_by(@user.id)
      else
        scope.none
      end
    end
  end
end
