class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_project_by_id, only: %i[show edit update destroy]

  def index
    @projects = Project.includes(:bugs).all
  end

  def new
    redirect_to '/' unless current_user.user_type == 'manager'
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    @project.users << current_user
    if @project.save
      Development.where(user_id: current_user.id, project_id: @project.id).update(is_creater: true)
      redirect_to @project
    else
      render 'new'
    end
  end

  def show
    redirect_to '/' if @project.developments.find_by(user_id: current_user.id).nil?
    @creater = @project.developments.find_by(is_creater: true).user
  end

  def edit
    redirect_to '/' unless @project.developments.find_by(is_creater: true).user_id == current_user.id
  end

  def update
    if @project.update(project_params)
      redirect_to @project
    else
      render 'edit'
    end
  end

  def destroy
    @project.destroy

    redirect_to projects_path
  end

  private

  def find_project_by_id
    @project = Project.find_by(id: params[:id])
  end

  def project_params
    params.require(:project).permit(:title)
  end
end
