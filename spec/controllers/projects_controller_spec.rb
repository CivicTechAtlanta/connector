require 'rails_helper'

RSpec.describe ProjectsController, :type => :controller do
  render_views

  let!(:project1) { FactoryGirl.create(:project) }
  let!(:project2) { FactoryGirl.create(:project) }

  describe "GET 'index'" do
    it "works" do
      get :index
      expect(response).to be_success
    end

    it "shows the projects" do
      get :index
      expect(response.body).to include(project1.name, project1.description.first(50))
      expect(response.body).to include(project2.name, project2.description.first(50))
    end
  end

  describe "GET 'show'" do
    let!(:person1) { FactoryGirl.create(:person) }
    let!(:unused_person) { FactoryGirl.create(:person) }

    before(:each) do
      project1.people << person1
    end

    it "works" do
      get :show, id: project1.id
      expect(response).to be_success
    end

    it "shows the project" do
      get :show, id: project1.id
      expect(response.body).to include(project1.name)
      expect(response.body).to include(project1.description)
    end

    it "shows the people" do
      get :show, id: project1.id
      expect(response.body).to include(person1.name)
    end
  end
end
