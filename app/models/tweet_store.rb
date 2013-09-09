# This really feels like a controller to me, not a model

require 'json'
require 'redis'
require 'tweetstream'

class TweetStore

  def initialize(search_terms)
    @tweet_count = 0
    @interval = 30
    @search_terms = search_terms
    @start_time = Time.new
    @db = REDIS
  end

  def time_reset
    @start_time = Time.new
  end

  def check_timer
    if (Time.now - @start_time >= @interval)
      @search_terms.each do |term|
        redis_trip = RedisTrip.create(search_term: term, tweet_count: @db.LLEN(term.hashtag))
        redis_trip.spike.create(search_term: term) if redis_trip.histogram > INTERESTING_MOMENT
      end
      @db.expire("#{something_else}", 0)
      time_reset
    end 
  end

  def push(hashtags)
    redis_keys = []
    hashtags.each { |tag| redis_keys << tag }
    redis_keys.each do |key|
      @db.LPUSH(key, hashtags.to_json) # Can we pass in something else? 
    end
  end
end
