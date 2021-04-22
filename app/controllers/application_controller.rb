class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:alert] = 'Access denied'
    redirect_to(request.referer || root_path)
  end
end
