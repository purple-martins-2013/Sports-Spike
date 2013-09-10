class EventsController < ApplicationController

  def app
  end

  def index
    @events = Event.all
    render json: @events.to_json(:include => :spikes)
  end
end