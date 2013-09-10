class TweetsController < ApplicationController
 
  def index
    store = TweetStore.new
    @redis_trip = RedisTrip.all.reverse_order
    @tweets = store.tweets
    @espn=ESPN.get_nfl_scores(2013, 1)
  end
end
