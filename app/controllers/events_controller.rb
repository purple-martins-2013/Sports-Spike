class EventsController < ApplicationController

  def app
  end

  def index
    render json: Event.includes(:spikes)
  end

  # def show
  #   render json: Event.find(params[:id]).includes(:spikes)
  # end

end
