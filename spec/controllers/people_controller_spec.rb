require 'rails_helper'

RSpec.describe PeopleController, :type => :controller do
  render_views

  let!(:person) { FactoryGirl.create(:person) }
  let!(:user) { FactoryGirl.create(:user) }
  let!(:user2) { FactoryGirl.create(:user, email: "test1234@test.com", uid: "123545", person_id: person.id) }


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
    context "with a not logged in user" do
      it "does not work" do
        get :edit, id: person.id
        expect(response).to redirect_to root_path
      end
    end

    context "with a logged in user that does not belong to this person" do
      it "does not work" do
        sign_in user
        get :edit, id: person.id
        expect(response).to redirect_to root_path
      end
    end

    context "with a logged in user that does belong to this person" do
      it "works" do
        sign_in user2
        get :edit, id: person.id
        expect(response).to be_success
      end
    end
  end

  describe "POST 'update'" do
    context "with a not logged in user" do
      it "does not update a person" do
        post :update, id: person.id, person: {email: "test@test.com", name: "test"}
        expect(response).to redirect_to root_path
      end
    end

    context "with a logged in user that does not belong to this person" do
      it "does not update a person" do
        sign_in user
        post :update, id: person.id, person: {email: "test@test.com", name: "test"}
        expect(response).to redirect_to root_path
      end
    end

    context "with a logged in user that does belong to this person" do
      it "updates a person" do
        sign_in user2
        post :update, id: person.id, person: {email: "test@test.com", name: "test"}
        person.reload
        expect(person.email).to eq("test@test.com")
        expect(person.name).to eq("test")
      end
    end
  end
end
