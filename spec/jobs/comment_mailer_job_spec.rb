require 'rails_helper'

RSpec.describe CommentMailerJob do
  before(:each) { ActionMailer::Base.deliveries.clear }
  let!(:project) { FactoryGirl.create(:project) }

  let!(:person1) { FactoryGirl.create(:person, user: FactoryGirl.create(:user)) }
  let!(:person2) { FactoryGirl.create(:person, user: FactoryGirl.create(:user)) }
  let!(:person3) { FactoryGirl.create(:person, user: FactoryGirl.create(:user)) }

  let!(:comment1) { project.comments.create!(title: Faker::Lorem.words(5).join(" "), comment: Faker::Lorem.paragraph, user: person1.user) }
  let!(:comment2) { project.comments.create!(title: Faker::Lorem.words(5).join(" "), comment: Faker::Lorem.paragraph, user: person1.user) }

  subject { CommentMailerJob.perform_async(project, person1) }

  context "With one user on the project" do
    before(:each) { project.people << person1 }

    it "should not send an email" do
      expect {
        subject
      }.not_to change{ ActionMailer::Base.deliveries.size }
    end
  end

  context "With two users on the project" do
    before(:each) { project.people << person1 }
    before(:each) { project.people << person2 }

    it "sends an email" do
      expect {
        subject
      }.to change{ ActionMailer::Base.deliveries.size }.by(1)
    end

    it "sends to the correct person" do
      subject
      mail = ActionMailer::Base.deliveries.last
      expect(mail.to).to eq([person2.user.email])
    end

    context 'with a person without a user' do
      before(:each) { person2.user.destroy }

      it "should not send an email" do
        expect {
          subject
        }.not_to change{ ActionMailer::Base.deliveries.size }
      end
    end
  end

  context "With three users on the project" do
    before(:each) { project.people << person1 }
    before(:each) { project.people << person2 }
    before(:each) { project.people << person3 }

    it "sends two emails" do
      expect {
        subject
      }.to change{ ActionMailer::Base.deliveries.size }.by(2)
    end

    it "sends to the correct people" do
      subject
      expect(ActionMailer::Base.deliveries.first.to).to eq([person2.user.email])
      expect(ActionMailer::Base.deliveries.last.to).to eq([person3.user.email])
    end
  end

end
