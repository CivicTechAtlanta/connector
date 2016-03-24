Time::DATE_FORMATS[:comment] = "%m-%d-%Y"
Time::DATE_FORMATS[:event] = lambda { |time|
  day_format = ActiveSupport::Inflector.ordinalize(time.in_time_zone('Eastern Time (US & Canada)').day)
  time = time.in_time_zone('Eastern Time (US & Canada)')
  time.strftime("%B #{day_format} %l:%M %p")
}
