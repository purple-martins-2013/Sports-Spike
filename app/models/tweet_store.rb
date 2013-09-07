require 'json'
require 'redis'
require 'tweetstream'

class TweetStore
  attr_reader :tweet_count

  REDIS_KEY = 'redis_tweets'

  def initialize
    @db = Redis.new
    @tweet_count = 0
    @start_time = Time.new
    @interval = 60
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
      RedisTrip.create(time: Time.now, tweet_count: @tweet_count)
      count_reset
      time_reset
    end
     p @tweet_count
  end
end
