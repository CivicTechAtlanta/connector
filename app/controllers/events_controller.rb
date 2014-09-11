class EventsController < ApplicationController
  def index
    @events = Event.all.order(updated_at: :asc)
  end

  def show
    @event = Event.find(params[:id])
  end

end
