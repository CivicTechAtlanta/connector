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
    let!(:event) { FactoryGirl.create(:event) }
    let!(:unused_person) { FactoryGirl.create(:person) }

    before(:each) do
      project1.people << person1
      project1.events << event
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

    it "shows the events" do
      get :show, id: project1.id
      expect(response.body).to include(event.name)
    end
  end

  describe "GET 'New'" do
    let!(:user) { FactoryGirl.create(:user) }

    context "when the user is not logged in" do
      it "redirects" do
        get :new
        expect(response).to redirect_to root_path
      end
    end

    context "when the user is logged in" do
      it "works" do
        sign_in user
        get :new
        expect(response).to be_success
      end
    end
  end

  describe "POST 'Create'" do
    let!(:user) { FactoryGirl.create(:user) }

    context "when the user is not logged in" do
      it "redirects" do
        expect {
          post :create, project: {name: "Test", description: "Testing description."}
        }.to_not change{ Project.count }
        expect(response).to redirect_to root_path
      end
    end

    context "when the user is logged in" do
      it "works" do
        sign_in user
        expect {
          post :create, project: {name: "Test", description: "Testing description."}
        }.to change{ Project.count }.by(1)
        expect(response).to redirect_to Project.last
      end
    end
  end

  describe "GET 'Edit'" do
    let!(:person) { FactoryGirl.create(:person) }
    let!(:user) { FactoryGirl.create(:user, person_id: person.id) }
    let!(:user2) { FactoryGirl.create(:user, email: "testing123@example.com") }

    before(:each) do
      project1.people << person
    end

    context "when the user is not logged in" do
      it "does not work" do
        get :edit, id: project1.id
        expect(response).to redirect_to root_path
      end
    end

    context "when the user edits a project that they are not a member of" do
      it "does not work" do
        sign_in user2
        get :edit, id: project1.id
        expect(response).to redirect_to root_path
      end
    end

    context "when the user edits a project that they are a member of" do
      it "works" do
        sign_in user
        get :edit, id: project1.id
        expect(response).to be_success
      end
    end
  end

end
