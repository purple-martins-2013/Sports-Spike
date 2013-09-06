class RedisTrip < ActiveRecord::Base
  #TODO: Why can't I do this with a class variable?
  # @@redis_trip_cache = []
  @@uneventful_period_interval = 1000 # Hardcoded number of seconds between RedisTrips during uneventful periods of a game.

  validates :time, presence: true

  # after_create :push_to_cache

  def self.time_between_last_two_trips
    last_two = RedisTrip.order('time DESC').limit(2)
    last_two[-2].time - last_two[-1].time
  end

  def self.test
    @@redis_trip_cache
  end


  private

  # def push_to_cache
  #   @@redis_trip_cache << self
  #   @@redis_trip_cache.shift if @@redis_trip_cache.size > 5
  # end
end
