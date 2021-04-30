class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  around_action :set_current_user

  rescue_from Pundit::NotAuthorizedError, Pundit::NotDefinedError, NoMethodError, with: :redirection_path

  include Pundit

  private

  def redirection_path
    redirect_to root_path, alert: 'You are not authorized or page does not exist!'
  end

  def set_current_user
    Current.user = current_user
    yield
  ensure
    Current.user = nil
  end
end
