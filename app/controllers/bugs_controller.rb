class BugsController < ApplicationController

  def new
    @bug = Bug.new
  end

  def create
    project_params
  end

  private

  def project_params
    params.require(:bug).permit(:title, :description, :deadline, :screenshot, :type, :status)
  end
end
