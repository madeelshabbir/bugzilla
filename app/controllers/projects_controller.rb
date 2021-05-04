# frozen_string_literal: true

class ProjectsController < ApplicationController
  before_action :set_project, except: %i[index new create]

  def index
    @projects = policy_scope(Project).page(params[:page]).per(10)

    @projects.each { |project| authorize project }
  end

  def new
    @project = authorize Project.new
  end

  def create
    @project = authorize current_user.created_projects.new(project_params)

    if @project.save
      redirect_to @project
    else
      render :new
    end
  end

  def show
    @users = @project.users.page(params[:page]).per(10)

    @available_users = User.available(@project.id)
  end

  def edit
    # Do Nothing
  end

  def update
    if @project.update(project_params)
      redirect_to @project
    else
      render :edit
    end
  end

  def destroy
    if @project.destroy
      redirect_to projects_path
    else
      render :index
    end
  end

  private

  def set_project
    @project = authorize Project.find_by(id: params[:id])
  end

  def project_params
    params.require(:project).permit(:title)
  end
end
