require 'rails_helper'

RSpec.describe PeopleController, :type => :controller do
  render_views

  describe "GET 'show'" do
    let!(:person) { FactoryGirl.create(:person) }
    let!(:project) { FactoryGirl.create(:project) }

    before(:each) do
      project.people << person
    end

    it "works" do
      get :show, id: person.id
      expect(response).to be_success
    end

    it "shows the person" do
      get :show, id: person.id
      expect(response.body).to include(person.name)
    end

    it "shows the person's projects" do
      get :show, id: person.id
      expect(response.body).to include(project.name)
    end
  end
end
