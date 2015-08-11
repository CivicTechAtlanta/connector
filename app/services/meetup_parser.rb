
###
#  Fetches data from Meetup and calls Events::Creator for insertion into database
class MeetupParser

  def self.fetch_and_insert

    uri = URI('http://www.meetup.com/codeforatlanta/events/ical/')

    cals = Icalendar.parse(Net::HTTP.get(uri))

    cal = cals.first

    cal.events.each do |event|

      # title, description, url, start_at, end_at, location
      event_struct = OpenStruct.new(
        title: event.summary.to_s,
        description: event.description.to_s, # TODO this is a short description. Need to scrape for full description
        url: event.url.to_s,
        location: event.location.to_s,
        start_at: event.dtstart.to_datetime.to_s,
        end_at: event.dtend.to_datetime
      )

      Events::Creator.call(event_struct)

    end

  end

end
