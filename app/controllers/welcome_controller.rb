class WelcomeController < ApplicationController
  layout 'static'

  def index
    @tags = ActsAsTaggableOn::Tag.all.pluck(:name)
    @event = Event.where("end_at > ?", Time.now).order(end_at: :asc).first
  end

  def about
  end

  def conduct
  end

  def spark
  end

end
