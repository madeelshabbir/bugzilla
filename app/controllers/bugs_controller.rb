class BugsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_project_by_id

  def index
    redirect_to '/' and return if @project.nil?

    if developer_and_not_in_project?
      redirect_to projects_path
    else
      @bugs = @project.bugs.all
    end
  end

  def new
    if @project.nil? || current_user.user_type != 'qa'
      redirect_to '/'
    else
      @bug = @project.bugs.build
    end
  end

  def create
    redirect_to '/' and return if @project.nil?

    @bug = @project.bugs.build(bug_params)
    @bug.user = current_user

    if @bug.save
      redirect_to project_bug_path(@bug.project_id, @bug.id)
    else
      render 'new'
    end
  end

  def update
    redirect_to '/' and return if @project.nil?

    @bug = @project.bugs.find_by(id: params[:id])
    redirect_to and return project_bugs_path(@project.id) if @bug.nil?

    if params[:bug][:status].nil? || current_user.user_type != 'developer'
      redirect_to project_bug_path(@bug.project_id, @bug.id)
    elsif @bug.update(status: params[:bug][:status], user_id: current_user.id)
      redirect_to project_bug_path(@bug.project_id, @bug.id)
    else
      render 'show'
    end
  end

  def show
    redirect_to '/' and return if @project.nil?

    redirect_to projects_path and return if developer_and_not_in_project?

    @bug = @project.bugs.find_by(id: params[:id])
    redirect_to project_bugs_path(@project.id) if @bug.nil?
  end

  def destroy
    redirect_to '/' and return if @project.nil?

    @bug = @project.bugs.find_by(id: params[:id])
    redirect_to and return project_bugs_path(@project.id) if @bug.nil?

    @bug.destroy
    redirect_to project_bugs_path(@project.id)
  end

  private

  def find_project_by_id
    @project = Project.find_by(id: params[:project_id])
  end

  def developer_and_not_in_project?
    current_user.user_type == 'developer' && current_user.developments.find_by(project_id: @project.id).nil?
  end

  def bug_params
    params.require(:bug).permit(:title, :description, :deadline, :screenshot, :_type)
  end
end
