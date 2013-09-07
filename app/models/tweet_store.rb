require 'json'
require 'redis'
require 'tweetstream'

class TweetStore
  attr_reader :tweet_count

  REDIS_KEY = 'redis_tweets'
  # NUM_TWEETS = 10000
  CACHE_THRESHOLD = 10

  def initialize
    @db = Redis.new
    @tweet_count = 0
  end

  # def tweets(limit=10, since=0)
  #   @db.LRANGE(REDIS_KEY, 0, limit -1).collect {|t|
  #       (JSON.parse(t))
  #     }
  # end

  def push(data)
    @db.LPUSH(REDIS_KEY, data.to_json)
    p @db
    @tweet_count += 1
    p @tweet_count
    if (@tweet_count > CACHE_THRESHOLD)
      RedisTrip.create(time: Time.now)
      # p RedisTrip.test
      # @db.LTRIM(REDIS_KEY, 0, NUM_TWEETS)
      @tweet_count = 0
    end
  end
end
