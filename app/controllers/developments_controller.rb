class DevelopmentsController < ApplicationController
  def add_member
    Development.create(user_id: params[:member], project_id: params[:project_id])
  end

  def delete_member
    @member = Development.find_by(user_id: params[:id], project_id: params[:project_id])
    @member.destroy
  end
end
