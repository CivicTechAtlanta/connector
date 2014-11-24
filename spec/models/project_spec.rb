require 'rails_helper'

RSpec.describe Project, :type => :model do
  subject { FactoryGirl.create(:project) }

  describe "url validation" do
    it "handles empty urls" do
      subject.urls = []
      expect(subject).to be_valid
    end

    it "handles valid urls" do
      subject.urls = [{ "Code Repository" => Faker::Internet.url }, { "Website" => Faker::Internet.url }]
      expect(subject).to be_valid
    end

    it "handles invalid urls" do
      subject.urls = [{ "CodeRepository" => Faker::Internet.url }]
      expect(subject).not_to be_valid
    end
  end
end
