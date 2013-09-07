class TweetsController < ApplicationController
 
  def index
    store = TweetStore.new
    @redis_trip = RedisTrip.all.reverse_order
    # @tweets = store.tweets
  end
end
