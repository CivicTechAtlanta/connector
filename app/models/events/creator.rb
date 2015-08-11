class Events::Creator
  def self.call(*args)
    new(*args).call
  end

  def initialize(event_data)
    @event_data = event_data
  end

  def call
    Event.where(url: event_data.url).first_or_initialize.tap do |event|
      MIRRORED_FIELDS.each do |field|
        event.send("#{field}=", event_data.send(field))
      end

      event.save!
    end
  end

  private

  # title, description, url, start_at, end_at, location
  attr_reader :event_data

  MIRRORED_FIELDS = [:title, :description, :start_at, :end_at, :location]

  def existing_event
    @existing_event ||= Event.find_by(url: event_data.url)
  end
end
