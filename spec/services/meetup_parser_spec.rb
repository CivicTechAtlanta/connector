require 'rails_helper'

RSpec.describe MeetupParser do
  subject { MeetupParser.fetch_and_insert }

  it "creates the correct number of events", vcr: { cassette_name: "meetup-parser-aug-10-2015" } do
    expect { subject }.to change{ Event.count }.by(3)
  end

  it "grabs all of the correct information", vcr: { cassette_name: "meetup-parser-aug-10-2015" } do
    subject
    event = Event.first
    expect(event.title).to eq("Civic Hack Night at Atlanta Tech Village")
    expect(event.location).to eq("Atlanta Tech Village, First Floor (3423 Piedmont Road NE, Atlanta, GA)")
    expect(event.url).to eq("http://www.meetup.com/codeforatlanta/events/224375636/")
    expect(event.start_at).to eq(DateTime.parse("Tue, 25 Aug 2015 19:00:00 EDT"))
    expect(event.end_at).to eq(DateTime.parse("Tue, 25 Aug 2015 21:30:00 EDT"))
    expect(event.description).to start_with("Code for Atlanta hack nights are all about getting stuff done")
    expect(event.description).to end_with("at the Village!")
  end
end
