class ProjectsController < ApplicationController
  before_action :set_project, except: %i[index new create]

  def index
    if current_user.developer?
      @projects = Project
                  .joins(:project_users)
                  .where('project_users.user_id = ?', current_user.id)
                  .page(params[:page])
                  .per(5)
    else
      @projects = Project.page(params[:page]).per(5)
    end
  end

  def new
    authorize Project

    @project = Project.new
  end

  def create
    authorize Project

    @project = Project.new(project_params)
    @project.users << current_user
    @project.creator = current_user

    if @project.save
      redirect_to @project
    else
      render :new
    end
  end

  def show
    authorize @project

    @users = @project.users.page(params[:page]).per(3)
  end

  def edit
    authorize @project
  end

  def update
    authorize @project

    if @project.update(project_params)
      redirect_to @project
    else
      render :edit
    end
  end

  def destroy
    authorize @project

    @project.destroy
    redirect_to projects_path
  end

  private

  def set_project
    @project = Project.find_by(id: params[:id])
  end

  def project_params
    params.require(:project).permit(:title)
  end
end
