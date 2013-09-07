class EventsController < ApplicationController

  def app
  end

  def index
    render json: Event.all
  end

end
