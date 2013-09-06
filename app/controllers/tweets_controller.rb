class TweetsController < ApplicationController
 
  def index
    store = TweetStore.new
    @redis_trip = RedisTrip.all.reverse_order
    @tweets = store.tweets
    @time = RedisTrip.time_between_last_two_trips
  end
end
