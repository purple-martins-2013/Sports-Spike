class TweetsController < ApplicationController

  

  def index
    store = TweetStore.new
    @tweets = store.tweets
    p @tweets
  end
end
