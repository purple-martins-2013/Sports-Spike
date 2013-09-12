class RedisTripsController < ApplicationController
  
  def index
  end
  
  def teams
    @trips = RedisTrip.all
    @teams = SearchTerm.all
  end


  def team_pulse
    @trips = RedisTrip.where(search_term_id: params[:search_term_id])
    @team_name = @trips.first.search_term.hashtag
  end
end
