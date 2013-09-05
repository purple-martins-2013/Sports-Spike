require 'json'
require 'redis'
require 'tweetstream'

class TweetStore
  REDIS_KEY = 'tweets'
  NUM_TWEETS = 20
  TRIM_THRESHOLD = 100

  def initialize
    @db = Redis.new
    @trim_count = 0
  end

  def tweets(limit=15, since=0)
    @db.LRANGE(REDIS_KEY, 0, limit -1).collect {|t|
      Tweet.new(JSON.parse(t))
      }.drop_while {|t| t.received_at <= since}
  end

  def push(data)
    p data
    p @db.push_head(REDIS_KEY, data.to_json)

    @trim_count += 1
    if (@trim_count > 100)
      @db.list_trim(REDIS_KEY, 0, NUM_TWEETS)
      @trim_count = 0
    end
  end
end
