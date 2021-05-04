# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: Figaro.env.smtp_user_name
  layout 'mailer'
end
