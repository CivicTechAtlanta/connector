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
  end
end
