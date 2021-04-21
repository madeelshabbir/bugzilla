class ProjectsController < ApplicationController
  before_action :set_project, except: %i[index new create]

  def index
    if current_user.developer?
      @projects = Project.joins(:project_users).includes(:bugs).where('project_users.user_id = ?', current_user.id).last(10)
    else
      @projects = Project.includes(:bugs).last(10)
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
    # Do nothing
  end

  def edit
    # Do nothing
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

  def set_project
    @project = Project.find_by(id: params[:id])
    redirect_to root_path if @project.nil?

    authorize @project
  end

  def project_params
    params.require(:project).permit(:title)
  end
end
