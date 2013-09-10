class RedisTripsController < ApplicationController
 
  def index
  end

  def render_data
    created_at = RedisTrip.where('search_term_id = 15').pluck('created_at')
    tweet_count =  RedisTrip.where('search_term_id = 15').pluck('tweet_count')
    render :json => created_at.zip(tweet_count)
  end
end
