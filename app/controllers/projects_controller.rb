class ProjectsController < ApplicationController
  before_filter :authenticate_user!, only: [:new, :create, :edit, :update]
  before_filter :verify_user_belongs_to_project, only: [:edit, :update]

  def has_access_to_edit?
    project.people.include? current_user.person
  end

  def verify_user_belongs_to_project
    unless has_access_to_edit?
      redirect_to('/')
      flash[:danger] = "You must be a member of the project to edit it."
    end
  end

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

  def edit
    @project = project
  end

  def update
    if project.update(project_params)
      flash[:success] = "Project successfully updated!"
    else
      flash[:danger] = "We're sorry, your information could not be updated. Name and description are required fields."
    end
    redirect_to project
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
