###
#  Fetches data from Meetup and calls Events::Creator for insertion into database
class MeetupParser
  def self.fetch_and_insert
    uri = URI('http://api.meetup.com/codeforatlanta/upcoming.ical')
    cals = Icalendar::Calendar.parse(Net::HTTP.get(uri))
    cal = cals.first
    cal.events.each do |event|
      # get full description from the HTTP page itself
      event_page = Nokogiri::HTML(Net::HTTP.get(URI(event.url.to_s)))
      full_description = event_page.css("[itemprop=description]").text || event.description.to_s

      # title, description, url, start_at, end_at, location
      event_struct = OpenStruct.new(
        title: event.summary.to_s,
        description: full_description.strip,
        url: event.url.to_s,
        location: event.location.to_s,
        start_at: event.dtstart.to_datetime.to_s,
        end_at: event.dtend.to_datetime.to_s
      )

      Events::Creator.call(event_struct)
    end
  end
end
