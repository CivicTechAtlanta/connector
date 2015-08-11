namespace :meetup do
  desc "Fetch upcoming events from meetup"

  task scrape: :environment do
    MeetupParser.fetch_and_insert
  end
end
