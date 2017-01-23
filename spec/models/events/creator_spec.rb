require 'rails_helper'

RSpec.describe Events::Creator, :type => :model do

  let!(:existing_event) { FactoryGirl.create(:event) }
  let!(:data) { OpenStruct.new(existing_event.attributes.slice("title", "description", "url", "location", "start_at", "end_at")) }

  subject { Events::Creator.call(data) }

  let(:new_start_at) { data.start_at + 1.minute }
  let(:new_end_at) { data.end_at + 1.minute }

  before(:each) {
    data.title = "New"
    data.description = "New Desc"
    data.location = "New Location"
    data.start_at = new_start_at
    data.end_at = new_end_at
  }

  it "doesn't add a new event" do
    expect { subject }.not_to change{ Event.count }
  end

  it "updates the changed fields" do
    subject
    existing_event.reload

    expect(existing_event.title).to eq("New")
    expect(existing_event.description).to eq("New Desc")
    expect(existing_event.location).to eq("New Location")
    expect(existing_event.start_at).to be_within(1).of(new_start_at)
    expect(existing_event.end_at).to be_within(1).of(new_end_at)
  end

  context "with a new url" do
    before(:each) { data.url = "url" }

    it "creates a new Event" do
      expect { subject }.to change{ Event.count }.by(1)
    end

    it "has the correct data" do
      subject
      event = Event.last
      expect(event.title).to eq("New")
      expect(event.description).to eq("New Desc")
      expect(event.location).to eq("New Location")
      expect(event.start_at).to be_within(1).of(new_start_at)
      expect(event.end_at).to be_within(1).of(new_end_at)
      expect(event.url).to eq("url")
    end
  end
end
