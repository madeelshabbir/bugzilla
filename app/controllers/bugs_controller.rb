class BugsController < ApplicationController
  before_action :set_project
  before_action :set_bug, only: %i[update show destroy]

  def index
    @bugs = @project.bugs.page(params[:page]).per(10)

    @bugs.each { |bug| authorize bug }

    @own_bugs = policy_scope(@bugs).page(params[:page]).per(5)
  end

  def new
    @bug = authorize @project.bugs.build
  end

  def create
    @bug = authorize @project.bugs.build(bug_params)

    if @bug.save
      redirect_to project_bug_path(@bug.project_id, @bug.id)
    else
      render :new
    end
  end

  def update
    if @bug.update(status: params[:bug][:status], assignee_id: current_user.id)
      redirect_to project_bug_path(@bug.project_id, @bug.id)
    else
      render :show
    end
  end

  def show
    # Do Nothing
  end

  def destroy
    if @bug.destroy
      redirect_to project_bugs_path(@project.id)
    else
      render :index
    end
  end

  private

  def set_project
    @project = Project.find_by(id: params[:project_id])
  end

  def set_bug
    @bug = authorize @project.bugs.find_by(id: params[:id])
  end

  def bug_params
    params.require(:bug).permit(:title, :description, :deadline, :screenshot, :bug_type)
  end
end
