# frozen_string_literal: true

class BugMailer < ApplicationMailer
  before_action :set_project_and_bug

  def bug_reported
    emails = @project.users.developer.pluck(:email)
    mail to: emails, subject: "New Bug/Feature is reported in #{@project.title}"
  end

  private

  def set_project_and_bug
    @project = params[:project]
    @bug = params[:bug]
  end
end
