class BugsController < ApplicationController
  before_action :set_project
  before_action :set_bug, only: %i[update show destroy]

  rescue_from Pundit::NotAuthorizedError, Pundit::NotDefinedError, NoMethodError do |exception|
    redirect_to @project.nil? ? root_path : project_bugs_path(@project.id), alert: exception.message
  end

  def index
    @bugs = @project.bugs.page(params[:page]).per(3)
    authorize @bugs.first
  end

  def new
    @bug = @project.bugs.build

    authorize @bug
  end

  def create
    @bug = @project.bugs.build(bug_params)
    @bug.creator = current_user
    @bug.assignee = User.new

    authorize @bug

    if @bug.save
      redirect_to project_bug_path(@bug.project_id, @bug.id)
    else
      render :new
    end
  end

  def update
    authorize @bug

    if params[:bug][:status].nil? || @bug.update(status: params[:bug][:status], assignee_id: current_user.id)
      redirect_to project_bug_path(@bug.project_id, @bug.id)
    else
      render :show
    end
  end

  def show
    authorize @bug
  end

  def destroy
    authorize @bug

    @bug.destroy
    redirect_to project_bugs_path(@project.id)
  end

  private

  def set_project
    @project = Project.find_by(id: params[:project_id])
  end

  def set_bug
    @bug = @project.bugs.find_by(id: params[:id])
  end

  def bug_params
    params.require(:bug).permit(:title, :description, :deadline, :screenshot, :bug_type)
  end
end
