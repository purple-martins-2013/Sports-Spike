require 'json'
require 'redis'
require 'tweetstream'

class TweetStore
  attr_reader :trim_count

  REDIS_KEY = 'tweets'
  NUM_TWEETS = 0
  TRIM_THRESHOLD = 100

  def initialize
    @db = Redis.new
    @trim_count = 0
  end

  def tweets(limit=100, since=0)
    @db.LRANGE(REDIS_KEY, 0, limit -1).collect {|t|
        (JSON.parse(t))
      }
  end

  def push(data)
    @db.LPUSH(REDIS_KEY, data.to_json)

    @trim_count += 1
    if (@trim_count > TRIM_THRESHOLD)
      RedisTrip.create(time: Time.now)
      @db.LTRIM(REDIS_KEY, 0, NUM_TWEETS)
      @trim_count = 0
    end
  end
end
