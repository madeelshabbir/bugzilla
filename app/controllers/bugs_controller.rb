class BugsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_project_by_id

  def index
    @bugs = @project.bugs.all
  end

  def new
    @bug = @project.bugs.build
  end

  def create
    @bug = @project.bugs.build(bug_params)
    @bug.user = current_user

    if @bug.save
      redirect_to project_bug_path(@bug.project_id, @bug.id)
    else
      render 'new'
    end
  end

  def show
    @bug = @project.bugs.find_by(id: params[:id])
  end

  def destroy
    @bug = @project.bugs.find_by(id: params[:id])
    @bug.destroy

    redirect_to 'index'
  end

  private

  def find_project_by_id
    @project = Project.find_by(id: params[:project_id])
    redirect_to '/' if @project.nil?
  end

  def bug_params
    params.require(:bug).permit(:title, :description, :deadline, :screenshot, :_type, :status)
  end
end
