class ProjectsController < ApplicationController
  before_filter :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_filter :verify_user_belongs_to_project, only: [:edit, :update, :destroy]
  before_filter :verify_project_creator, only: [:destroy]

  def index
    @projects = projects.order(updated_at: :asc)
  end

  def show
    @project = project
    @comments = @project.comments.order(created_at: :asc)
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params.merge(urls: construct_urls))
    if @project.save
      @project.people << current_user.person
      redirect_to @project
      flash[:success] = "Project successfully created!"
    else
      render 'new'
      flash[:danger] = "Please fill in all fields."
    end
  end

  def edit
    @project = project
  end

  def update
    update_params = project_params
    update_params.merge!(urls: construct_urls)
    if project.update(update_params)
      redirect_to project
      flash[:success] = "Project successfully updated!"
    else
      render 'edit'
      flash[:danger] = "We're sorry, your information could not be updated. Name and description are required fields."
    end
  end

  def destroy
    project.destroy
    flash[:success] = "Project successfully deleted!"
    redirect_to projects_path
  end

  def contribute
    project.people << current_person unless project.people.include?(current_person)
    redirect_to project, notice: "You are now listed as a contributor"
  end

  def uncontribute
    project.people.delete(current_person) if project.people.include?(current_person)
    redirect_to project, notice: "You are no longer listed as a contributor"
  end

  private

  def projects
    Project.all
  end

  def project
    @project ||= projects.includes(:people).find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name, :description)
  end

  def has_access_to_update?
    project.people.include?(current_user.person)
  end

  def verify_user_belongs_to_project
    unless has_access_to_update?
      redirect_to root_path
      flash[:danger] = "You must be a member of the project to edit it."
    end
  end

  def verify_project_creator
    unless project.people.first == current_user.person
      redirect_to project
    end
  end

  def url_params
    params.require(:project).permit(:url_types, :urls)
  end

  def construct_urls
    params.fetch(:project).fetch(:url_types, []).each_with_index.map do |type, i|
      [type, params.fetch(:project).fetch(:urls, [])[i]]
    end
  end
end
