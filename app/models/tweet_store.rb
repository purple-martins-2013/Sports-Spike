# This really feels like a controller to me, not a model

require 'json'
require 'redis'
require 'tweetstream'

class TweetStore
  attr_reader :tweet_count

  REDIS_KEY = 'redis_tweets'

  def initialize
    @tweet_count = 0
    @interval = 30
    @start_time = Time.new
    @db = REDIS
  end

  def count_reset
    @tweet_count = 0
  end

  def inc_tweet_count
    @tweet_count += 1
  end

  def time_reset
    @start_time = Time.new
  end

  def push(data)
    @db.LPUSH(REDIS_KEY, data.to_json)
    inc_tweet_count
    if (Time.now - @start_time >= @interval)
      redis_trip = RedisTrip.create(time: Time.now, tweet_count: @tweet_count)
      count_reset
      time_reset
      Spike.create if redis_trip.histogram > INTERESTING_MOMENT
      @db.expire("redis_db", 0) 
    end
     p @tweet_count
  end
end
