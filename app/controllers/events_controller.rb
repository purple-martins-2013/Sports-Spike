class EventsController < ApplicationController

  def app
  end

  def index
    @events = Event.all
    render json: @events.to_json(:include => :spikes)
  end

  # def show
  #   render json: Event.find(params[:id]).includes(:spikes)
  # end

end
