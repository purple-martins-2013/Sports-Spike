module RedisTripHelper

  def sufficient_redis_trips_in_database(time_period)
     search_terms_redis_trip_count > time_period
  end

  def first_time_calculating_field(time_period)
    search_terms_redis_trip_count == time_period + 1
  end

  def search_terms_redis_trip_count
    RedisTrip.where("search_term_id = #{self.search_term_id}").count
  end

  def search_term_trips_ordered_by_create
    RedisTrip.where("search_term_id = #{self.search_term_id}").order('created_at DESC')
  end

  def smoothing_constant(n)
    2.0 / (n + 1)
  end

  def caluculate_ema(time_period, field)
    search_term_trips_ordered_by_create.limit(time_period).pluck(field).inject(:+) / time_period
  end
end
