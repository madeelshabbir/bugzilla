class BugsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_project_by_id

  def index
    @bugs = @project.bugs.all
  end

  def new
    redirect_to '/' unless current_user.user_type == 'qa'
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

  def edit
    find_bug_by_id
  end

  def update
    find_bug_by_id
    if @bug.update(bug_params)
      redirect_to @bug
    else
      render 'edit'
    end
  end

  def show
    find_bug_by_id
  end

  def destroy
    find_bug_by_id
    @bug.destroy

    redirect_to 'index'
  end

  private

  def find_project_by_id
    @project = Project.find_by(id: params[:project_id])
    redirect_to '/' if @project.nil?
  end

  def find_bug_by_id
    @bug = @project.bugs.find_by(id: params[:id])
    redirect_to project_bugs_path(@project.id) if @bug.nil?
  end

  def bug_params
    params.require(:bug).permit(:title, :description, :deadline, :screenshot, :_type, :status)
  end
end
