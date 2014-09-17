class PeopleController < ApplicationController
  def show
    @person = person
    @projects = projects(@person)
  end

  private

  def person
    Person.find(params[:id])
  end

  def projects(person)
    person.projects
  end
end
