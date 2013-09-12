class RedisTripsController < ApplicationController

  def index
    @trips = RedisTrip.all
    @teams = SearchTerm.all
  end

  def teams
    team_one = SearchTerm.find_by_hashtag(params[:team_one])
    p team_one
    team_two = SearchTerm.find_by_hashtag(params[:team_two])
    p team_two
    redirect_to search_term_path(team_one, team_two)
  end
end
