require 'rails_helper'

RSpec.describe ProjectsController, :type => :controller do
  render_views

  let!(:project1) { FactoryGirl.create(:project, description: "# Project 1") }
  let!(:project2) { FactoryGirl.create(:project, description: "Project 2") }
  let!(:person) { FactoryGirl.create(:person) }
  let!(:person2) { FactoryGirl.create(:person) }
  let!(:user) { FactoryGirl.create(:user, person_id: person.id) }
  let!(:user2) { FactoryGirl.create(:user, email: "testing123@example.com", person_id: person2.id) }

  describe "GET 'index'" do
    it "works" do
      get :index
      expect(response).to be_success
    end

    it "shows the projects" do
      get :index
      expect(response.body).to include(project1.name.titlecase, "Project 1") # Tags stripped
      expect(response.body).to include(project2.name.titlecase, "Project 2")
    end

    context "with tags" do
      before(:each) do
        project1.tag_list.add("test")
        project1.description = "# Test"
        project1.save!
      end

      it "lists the project (without markdown)" do
        get :index, tag: "test"
        expect(response.body).to include(project1.name.titlecase)
        expect(response.body).not_to include(project2.name.titlecase)
        expect(response.body).not_to include('# Test')
      end
    end
  end

  describe "GET 'show'" do
    let!(:unused_person) { FactoryGirl.create(:person) }

    before(:each) do
      project1.people << person
    end

    it "works" do
      get :show, id: project1.id
      expect(response).to be_success
    end

    it "shows the project" do
      get :show, id: project1.id
      expect(response.body).to include(project1.name.titlecase)
      expect(response.body).to include(project1.markdown)
    end

    it "shows the people" do
      get :show, id: project1.id
      expect(response.body).to include(person.name)
    end

    context "with comments" do
      let!(:comment) { Comment.create!(commentable: project1, comment: "# Test") }

      it "shows the markdown comment" do
        get :show, id: project1.id
        expect(response.body).to include("<h1>Test</h1>")
      end

      it "doesn't show deleted comment" do
        comment.update!(deleted: true)
        get :show, id: project1.id
        expect(response.body).not_to include("<h1>Test</h1>")
      end
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
      before(:each) { sign_in(user) }

      it "works" do
        expect {
          post :create, project: {name: "Test", description: "Testing description."}
        }.to change{ Project.count }.by(1)
        expect(Project.last.people.first).to eq(user.person)
        expect(response).to redirect_to Project.last
      end

      it "can set the urls properly" do
        post :create, project: { name: "Test", description: "Testing description.", url_types: ["Code Repository", "Website"], urls: ["1", "2"] }
        expect(Project.last.urls).to eq([["Code Repository", "1"], ["Website", "2"]])
      end

      it "can set tags" do
        post :create, project: { name: "Test", description: "X", tag_list: "hi, test" }
        expect(Project.last.tags.count).to eq(2)
        expect(Project.last.tag_list).to match_array(["hi", "test"])
      end
    end
  end

  describe "GET 'Edit'" do
    before(:each) do
      project1.people << person
    end

    context "when the user is not logged in" do
      it "redirects" do
        get :edit, id: project1.id
        expect(response).to redirect_to root_path
      end
    end

    context "when the user is not a member of that project" do
      it "redirects" do
        sign_in user2
        get :edit, id: project1.id
        expect(response).to redirect_to root_path
      end
    end

    context "when the user is a member of that project" do
      it "edits the project" do
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

    context "when user is not logged in" do
      it "does not update a project" do
        post :update, id: project1.id, project: project_params
        project1.reload
        expect(project1.name).to_not eq("tester")
        expect(project1.description).to_not eq("testing123")
        expect(response).to redirect_to root_path
      end
    end

    context "when the user is not a member of that project" do
      it "does not update a project" do
        sign_in user2
        post :update, id: project1.id, project: project_params
        project1.reload
        expect(project1.name).to_not eq("tester")
        expect(project1.description).to_not eq("testing123")
        expect(response).to redirect_to root_path
      end
    end

    context "when the user is a member of that project" do
      before(:each) { sign_in(user) }

      it "updates a project" do
        post :update, id: project1.id, project: project_params
        project1.reload
        expect(project1.name).to eq("tester")
        expect(project1.description).to eq("testing123")
      end

      it "can set the urls properly" do
        project1.update!(urls: [])
        expect {
          post :update, id: project1.id, project: { url_types: ["Code Repository", "Website"], urls: ["1", "2"] }
        }.to change{ project1.reload.urls }.from([]).to([["Code Repository", "1"], ["Website", "2"]])
      end
    end
  end

  describe "POST 'destroy'" do
    let!(:person3) { FactoryGirl.create(:person) }
    let!(:user3) { FactoryGirl.create(:user, email: "user3@example.com", person_id: person3.id) }
    before(:each) do
      project1.people << person
      project1.people << person3
    end

    context "when user is not logged in" do
      it "redirects" do
        post :destroy, id: project1.id
        expect(project1.present?).to be(true)
        expect(response).to redirect_to root_path
      end
    end
    context "when the user is not a member of that project" do
      it "redirects" do
        sign_in user2
        post :destroy, id: project1.id
        expect(project1.present?).to be(true)
        expect(response).to redirect_to root_path
      end
    end
    context "when the user is a member of that project" do
      it "redirects" do
        sign_in user3
        post :destroy, id: project1.id
        expect(project1.present?).to be(true)
        expect(response).to redirect_to project1
      end
    end
    context "when the user is the creator of that project" do
      it "deletes the project" do
        sign_in user
        expect {
          post :destroy, id: project1.id
        }.to change(Project, :count).by(-1)
        expect(response).to redirect_to projects_path
      end
    end
  end

  describe "GET contribute" do
    before(:each) { sign_in(user) }

    it "adds me as a contributor" do
      expect {
        get :contribute, id: project1.id
      }.to change{ project1.people.include?(user.person) }.from(false).to(true)
    end

    it "redirects to the project" do
      get :contribute, id: project1.id
      expect(response).to redirect_to(project_path(project1))
    end

    it "can't add me twice" do
      project1.people << user.person
      expect {
        get :contribute, id: project1.id
      }.not_to change{ project1.people.include?(user.person) }.from(true)
    end
  end

  describe "GET uncontribute" do
    before(:each) { sign_in(user) }
    before(:each) { project1.people << user.person }

    it "remove me as a contributor" do
      expect {
        get :uncontribute, id: project1.id
      }.to change{ project1.people.include?(user.person) }.from(true).to(false)
    end

    it "redirects to the project" do
      get :uncontribute, id: project1.id
      expect(response).to redirect_to(project_path(project1))
    end

    it "can't remove me twice" do
      project1.people.delete(user.person)
      expect {
        get :uncontribute, id: project1.id
      }.not_to change{ project1.people.include?(user.person) }.from(false)
    end
  end
end
