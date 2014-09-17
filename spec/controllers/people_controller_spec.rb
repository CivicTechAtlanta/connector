require 'rails_helper'

RSpec.describe PeopleController, :type => :controller do
  render_views

  let!(:person) { FactoryGirl.create(:person) }

  describe "GET 'show'" do
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

  describe "GET 'edit'" do
    it "works" do
      get :edit, id: person.id
      expect(response).to be_success
    end
  end

  describe "POST 'update'" do
    it "updates a person" do
      post :update, id: person.id, person: {email: "test@test.com", name: "test"}
      person.reload
      expect(person.email).to eq("test@test.com")
      expect(person.name).to eq("test")
    end
  end
end
