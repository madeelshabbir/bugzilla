class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  include Pundit

  rescue_from Pundit::NotAuthorizedError, Pundit::NotDefinedError, NoMethodError do |exception|
    redirect_to root_path, alert: exception.message
  end
end
