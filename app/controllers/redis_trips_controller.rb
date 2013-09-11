class RedisTripsController < ApplicationController
  def index
    @trips = RedisTrip.all
    @teams = SearchTerm.all
  end
end
