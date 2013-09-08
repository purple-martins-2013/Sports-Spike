class RedisTrip < ActiveRecord::Base
  acts_as_reportable

  @@uneventful_period_interval = 1000 

  validates :time, presence: true

  def self.time_between_last_two_trips
    last_two = RedisTrip.order('time DESC').limit(2)
    last_two[-2].time - last_two[-1].time
  end

  def self.test
    @@redis_trip_cache
  end

end
