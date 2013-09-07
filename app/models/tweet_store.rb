require 'json'
require 'redis'
require 'tweetstream'

class TweetStore
  attr_reader :trim_count

  REDIS_KEY = 'tweets'
  NUM_TWEETS = 0
  TRIM_THRESHOLD = 100

  def initialize
    uri = URI.parse(ENV["REDISTOGO_URL"])
    @db = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
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
    p @trim_count
    if (@trim_count > TRIM_THRESHOLD)
      p RedisTrip.test
      RedisTrip.create(time: Time.now)
      p RedisTrip.test
      @db.LTRIM(REDIS_KEY, 0, NUM_TWEETS)
      @trim_count = 0
    end
  end
end
