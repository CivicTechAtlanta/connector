require 'rails_helper'

RSpec.describe CommentsController, :type => :controller do
  let(:user) { FactoryGirl.create(:user) }
  let(:project) { FactoryGirl.create(:project) }

  before(:each) { sign_in(user) }

  describe "POST create" do
    it "creates a comment" do
      expect {
        post :create, comment: "Test", project_id: project.id
      }.to change{ project.comments.count }.by(1)
    end

    it "redirects to the project" do
      post :create, comment: "Test", project_id: project.id
      expect(response).to redirect_to(project_path(project))
    end

    it "doesn't send any emails" do
      expect {
        post :create, comment: "Test", project_id: project.id
      }.not_to change{ ActionMailer::Base.deliveries.size }
    end

    context "with other people on the project" do
      let(:person1) { FactoryGirl.create(:person, user: FactoryGirl.create(:user)) }
      let(:person2) { FactoryGirl.create(:person, user: FactoryGirl.create(:user)) }

      before(:each) {
        project.people << person1
        project.people << person2
      }

      it "sends 2 emails" do
        expect {
          post :create, comment: "Test", project_id: project.id
        }.to change{ ActionMailer::Base.deliveries.size }.by(2)
      end
    end
  end
end
