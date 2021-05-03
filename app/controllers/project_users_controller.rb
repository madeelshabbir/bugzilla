# frozen_string_literal: true

class ProjectUsersController < ApplicationController
  rescue_from NoMethodError, with: :redirection_path

  def create
    params[:ids].each do |id|
      break unless authorize ProjectUser.create(user_id: id, project_id: params[:project_id])
    end

    redirect_to project_path(params[:project_id])
  end

  def destroy
    @project_user = authorize ProjectUser.find_by(user_id: params[:id], project_id: params[:project_id])

    if @project_user.destroy
      redirect_to project_path(params[:project_id])
    else
      render 'projects/show'
    end
  end

  private

  def redirection_path
    redirect_to project_path(params[:project_id]), alert: 'Page does not exist!'
  end
end
