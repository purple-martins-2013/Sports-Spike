require 'json'
require 'redis'
require 'tweetstream'

class TweetStore
  attr_reader :tweet_count

  REDIS_KEY = 'redis_tweets'
  # NUM_TWEETS = 10000
  CACHE_THRESHOLD = 60

  def initialize
    @db = Redis.new
    @tweet_count = 0
    @start_time = Time.new
  end

  # def tweets(limit=10, since=0)
  #   @db.LRANGE(REDIS_KEY, 0, limit -1).collect {|t|
  #       (JSON.parse(t))
  #     }
  # end

  def push(data)
    @db.LPUSH(REDIS_KEY, data.to_json)
    @tweet_count += 1
    
    if (Time.now - @start_time >= 60)
      RedisTrip.create(time: Time.now, tweet_count: @tweet_count)
      # p RedisTrip.test
      # @db.LTRIM(REDIS_KEY, 0, NUM_TWEETS)
      @tweet_count = 0
      @start_time = Time.new
    end
     p @tweet_count
  end
end
