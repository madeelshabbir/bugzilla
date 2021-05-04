# frozen_string_literal: true

class BugMailer < ApplicationMailer
  default to: -> { @project.users.developer.pluck(:email) }
  before_action :set_project_and_bug

  def bug_reported
    mail subject: "New Bug/Feature is reported in #{@project.title}"
  end

  private

  def set_project_and_bug
    @bug = params[:bug]
    @project = @bug.project
  end
end
