class ProjectsController < ApplicationController
  before_filter :authenticate_user!, only: [:new, :create]

  def index
    @projects = projects.order(updated_at: :asc)
  end

  def show
    @project = project
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      redirect_to (@project)
      flash[:success] = "Project successfully created!"
    else
      render('new')
      flash[:danger] = "Please fill in all fields."
    end
  end

  private

  def projects
    Project.all
  end

  def project
    projects.includes(:people, :events).find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name, :description)
  end
end
