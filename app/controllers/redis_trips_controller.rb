class RedisTripsController < ApplicationController
 
  def index
    @redis_trip_display = RedisTrip.all
    @chart_array = []
    created_at = RedisTrip.where('search_term_id = 15').pluck('created_at')
    tweet_count =  RedisTrip.where('search_term_id = 15').pluck('tweet_count')
    @chart_array << created_at.zip(tweet_count)
    render :json => @chart_array 
  end

end
