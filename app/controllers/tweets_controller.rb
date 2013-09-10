class TweetsController < ApplicationController
  def index
    store = TweetStore.new
    @redis_trip = RedisTrip.all
    
  end
end
