# frozen_string_literal: true

class ProjectUserPolicy < ApplicationPolicy
  def create?
    @record.project.creator_id == @user.id
  end

  def destroy?
    create?
  end
end
