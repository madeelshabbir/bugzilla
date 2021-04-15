class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_project_by_id, only: %i[show edit update destroy]

  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    @project.users << current_user
    if @project.save
      redirect_to @project
    else
      render 'new'
    end
  end

  def show
    find_project_by_id
  end

  def edit
    find_project_by_id
  end

  def update
    find_project_by_id

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
