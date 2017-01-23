require 'rails_helper'

RSpec.describe CommentsController, :type => :controller do
  let(:user) { FactoryGirl.create(:user) }
  let(:project) { FactoryGirl.create(:project) }

  before(:each) { sign_in(user) }

  describe 'POST create' do

    context 'when the user is not a robot' do
      let(:request!) { post :create, comment: 'Test', project_id: project.id, imahuman: ENV['IMAHUMAN'] }

      before do
        allow_any_instance_of(Recaptcha::Verify)
            .to receive(:verify_recaptcha)
                    .and_return(true)
      end

      it 'creates a comment' do
        expect {
          request!
        }.to change{ project.comments.count }.by(1)
      end

      it 'redirects to the project' do
        request!
        expect(response).to redirect_to(project_path(project))
      end

      it 'does not send any emails' do
        expect {
          request!
        }.not_to change{ ActionMailer::Base.deliveries.size }
      end

      context 'with other people on the project' do
        let(:person1) { FactoryGirl.create(:person, user: FactoryGirl.create(:user)) }
        let(:person2) { FactoryGirl.create(:person, user: FactoryGirl.create(:user)) }

        before(:each) {
          project.people << person1
          project.people << person2
        }

        it 'sends 2 emails' do
          expect {
            request!
          }.to change{ ActionMailer::Base.deliveries.size }.by(2)
        end
      end
    end
    
    context 'when the user might be a robot' do
      before do
        allow_any_instance_of(Recaptcha::Verify)
            .to receive(:verify_recaptcha)
                    .and_return(false)
      end

      context 'when the user has javascript turned off' do
        it 'should return forbidden' do
          post :create, comment: 'Test', project_id: project.id, imahuman: 'BANANA'

          expect(response).to have_http_status(:forbidden)
        end
      end

      context 'when the user does not properly meet captcha requirements' do
        it 'should return fobidden' do
          post :create, comment: 'Test', project_id: project.id, imahuman: ENV['IMAHUMAN']

          expect(response).to have_http_status(:forbidden)
        end
      end
    end
  end
end
