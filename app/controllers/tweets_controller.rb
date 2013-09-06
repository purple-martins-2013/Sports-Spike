class TweetsController < ApplicationController
 
  def index
    store = TweetStore.new
    @tweets = store.tweets
  end
end
