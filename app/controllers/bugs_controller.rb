class BugsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_project_by_id

  def index
    @bug = @project.bugs.all if redirect_to_root(@project)
  end

  def new
    redirect_to_root(@project)
  end

  def create
    if redirect_to_root(@project)
      @bug = @project.bugs.build(bug_params)
      @bug.user = current_user

      if @bug.save
        redirect_to project_bug_path(@bug.project_id, @bug.id)
      else
        render 'new'
      end
    end
  end

  def show
    if redirect_to_root(@project)
      @bug = @project.bugs.find_by(id: params[:id])
    end
  end

  def destroy
    if redirect_to_root(@project)
      @bug = @project.bugs.find_by(id: params[:id])
      @bug.destroy

      redirect_to 'index'
    end
  end

  private

  def find_project_by_id
    p @project = Project.find_by(id: params[:project_id])
  end

  def redirect_to_root(project)
    if project.nil?
      redirect_to '/'
      return false
    end

    true
  end

  def bug_params
    params.require(:bug).permit(:title, :description, :deadline, :screenshot, :_type, :status)
  end
end
