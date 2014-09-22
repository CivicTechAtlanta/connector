class PeopleController < ApplicationController
  before_filter :login_required, only: [:edit, :update]
  helper_method :current_user

  def has_access_to_edit?
    current_user.try!(:person) == person
  end

  def login_required
    if !has_access_to_edit?
      redirect_to('/')
      flash[:danger] = "You must be logged in to view this page."
    end
  end

  def show
    @person = person
    @projects = projects
  end

  def edit
    @person = person
  end

  def update
    if person.update(person_params)
      flash[:success] = "Information successfully updated!"
    else
      flash[:danger] = "We're sorry, your information could not be updated. Name and email are required fields."
    end
    redirect_to person
  end

  private

  def person
    @person ||= Person.find(params[:id])
  end

  def projects
    @person.projects
  end

  def person_params
    params.require(:person).permit(:name, :email, :image)
  end
end
