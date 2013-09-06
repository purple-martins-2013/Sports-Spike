class TweetsController < ApplicationController
 
  def index
    store = TweetStore.new
    @redistrip = RedisTrip.all.reverse_order
    @redistrip = RedisTrip.all.reverse_order
    @tweets = store.tweets
  end

  def show_closest_time_diff
    current_trip = RedisTrip[-1]
    p current_trip
    next_closest_trip = RedisTrip[-2]
    p next_closest_trip
  end
end
