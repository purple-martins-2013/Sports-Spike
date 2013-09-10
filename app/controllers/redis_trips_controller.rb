class RedisTripsController < ApplicationController
 
  def index
    @redis_trip_display = RedisTrip.all
  end

end
