# This really feels like a controller to me, not a model
require 'espn_scraper'
require 'json'
require 'redis'
require 'tweetstream'

class TweetStore

  INTERESTING_MOMENT = 10

  def initialize(search_terms)
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
      puts 'about to create RedisTrips' + '*' * 20
      @search_terms.each do |term|
        p 'here 1'
        p term
        redis_trip = RedisTrip.create(search_term_id: term.id, tweet_count: @db.LLEN(term.hashtag))
        p 'here 2'
        unless redis_trip.histogram.nil?
          p 'here 3'
          Spike.create(redis_trip: redis_trip) if redis_trip.histogram > INTERESTING_MOMENT
          p 'here 4'
        end
        p 'here 5'
      end
      p 'here 6'
      @db.flushall
      time_reset
      puts 'done with RedisTrip creation'
    end 
  end

  def push(hashtags)
    redis_keys = []
    p hashtags
    hashtags.each { |tag| redis_keys << tag }
    redis_keys.each do |key|
      @db.LPUSH(key, hashtags.to_json) # Can we pass in something else? 
    end
  end
end
