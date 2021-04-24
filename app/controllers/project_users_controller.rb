class ProjectUsersController < ApplicationController
  rescue_from NoMethodError do |exception|
    redirect_to project_path(@project.id), alert: exception.message
  end

  def add_user
    if ProjectUser.create(user_id: params[:member], project_id: params[:project_id])
      redirect_to project_path(params[:project_id])
    else
      render 'projects/show'
    end
  end

  def remove_user
    @project_user = ProjectUser.find_by(user_id: params[:id], project_id: params[:project_id])
    redirect_to project_path(params[:project_id]) if @project_user.destroy
  end
end
