require 'rails_helper'

RSpec.describe ProjectsController, :type => :controller do
  render_views

  let!(:project1) { FactoryGirl.create(:project) }
  let!(:project2) { FactoryGirl.create(:project) }
  let!(:person) { FactoryGirl.create(:person) }
  let!(:user) { FactoryGirl.create(:user, person_id: person.id) }
  let!(:user2) { FactoryGirl.create(:user, email: "testing123@example.com") }

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
    let!(:event) { FactoryGirl.create(:event) }
    let!(:unused_person) { FactoryGirl.create(:person) }

    before(:each) do
      project1.people << person
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
      expect(response.body).to include(person.name)
    end

    it "shows the events" do
      get :show, id: project1.id
      expect(response.body).to include(event.name)
    end
  end

  describe "GET 'New'" do
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

  describe "POST 'update'" do
    let!(:project_params) { {name: "tester", description: "testing123"} }
    before(:each) do
      project1.people << person
    end

    context "user is not logged in" do
      it "does not update a project" do
        post :update, id: project1.id, project: project_params
        project1.reload
        expect(project1.name).to_not eq("tester")
        expect(project1.description).to_not eq("testing123")
        expect(response).to redirect_to root_path
      end
    end

    context "with a logged in user that does not belong to this person" do
      it "does not update a project" do
        sign_in user2
        post :update, id: project1.id, project: project_params
        project1.reload
        expect(project1.name).to_not eq("tester")
        expect(project1.description).to_not eq("testing123")
        expect(response).to redirect_to root_path
      end
    end

    context "with a logged in user that does belong to this person" do
      it "updates a project" do
        sign_in user
        post :update, id: project1.id, project: project_params
        project1.reload
        expect(project1.name).to eq("tester")
        expect(project1.description).to eq("testing123")
      end
    end
  end
end
