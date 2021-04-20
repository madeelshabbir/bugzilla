class BugsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_project_by_id

  def index
    redirect_to root_path and return if @project.nil?

    @bugs = @project.bugs.all

    authorize @bugs.first
  end

  def new
    if @project.nil?
      redirect_to root_path
    else
      @bug = @project.bugs.build
    end
  end

  def create
    redirect_to root_path and return if @project.nil?

    @bug = @project.bugs.build(bug_params)
    @bug.user = current_user

    if @bug.save
      redirect_to project_bug_path(@bug.project_id, @bug.id)
    else
      render 'new'
    end
  end

  def update
    redirect_to root_path and return if @project.nil?

    @bug = @project.bugs.find_by(id: params[:id])
    redirect_to project_bugs_path(@project.id) and return if @bug.nil?

    authorize @bug

    if params[:bug][:status].nil? || current_user.developer?
      redirect_to project_bug_path(@bug.project_id, @bug.id)
    elsif @bug.update(status: params[:bug][:status], user_id: current_user.id)
      redirect_to project_bug_path(@bug.project_id, @bug.id)
    else
      render 'show'
    end
  end

  def show
    redirect_to root_path and return if @project.nil?

    @bug = @project.bugs.find_by(id: params[:id])
    redirect_to project_bugs_path(@project.id) if @bug.nil?

    authorize @bug
  end

  def destroy
    redirect_to root_path and return if @project.nil?

    @bug = @project.bugs.find_by(id: params[:id])
    redirect_to root_path project_bugs_path(@project.id) and return if @bug.nil?

    authorize @bug

    @bug.destroy
    redirect_to project_bugs_path(@project.id)
  end

  private

  def find_project_by_id
    @project = Project.find_by(id: params[:project_id])
  end

  def bug_params
    params.require(:bug).permit(:title, :description, :deadline, :screenshot, :_type)
  end
end
