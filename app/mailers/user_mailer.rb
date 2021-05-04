# frozen_string_literal: true

class UserMailer < ApplicationMailer
  before_action :set_user

  def signed_up
    email_with_name = %("#{@user.name}" <#{@user.email}>)
    mail to: email_with_name, subject: 'Thanks for Signing Up'
  end

  private

  def set_user
    @user = params[:user]
  end
end
