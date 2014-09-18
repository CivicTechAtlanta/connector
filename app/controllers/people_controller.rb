class PeopleController < ApplicationController
  before_filter :login_required, only: [:edit, :update]

  def show
    @person = person
    @projects = projects(@person)
  end

  def edit
    @person = person
  end

  def update
    person_update = person
    if person_update.update(person_params)
      flash[:success] = "Information successfully updated!"
    else
      flash[:danger] = "We're sorry, your information could not be updated. Name and email are required fields."
    end
    redirect_to person
  end

  private

  def person
    Person.find(params[:id])
  end

  def projects(person)
    person.projects
  end

  def person_params
    params.require(:person).permit(:name, :email, :image)
  end
end
