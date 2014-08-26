class ProjectsController < ApplicationController
  def index
    @projects = projects.order(updated_at: :asc)
  end

  def show
    @project = project
  end

  private

  def projects
    Project.all
  end

  def project
    projects.includes(:organizations, :people, :events).find(params[:id])
  end
end
