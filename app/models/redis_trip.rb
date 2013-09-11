class RedisTrip < ActiveRecord::Base
  include RedisTripHelper

  has_one :spike
  belongs_to :search_term
  
  SIGNAL_LINE_PERIOD = 2
  SHORT_EMA_PERIOD = 4
  LONG_EMA_PERIOD = 8

  before_create :populate_algorithm_fields




  def populate_algorithm_fields
    calculate_short_ema if sufficient_redis_trips_in_database(SHORT_EMA_PERIOD)
    calculate_long_ema if sufficient_redis_trips_in_database(LONG_EMA_PERIOD)
    calculate_macd if sufficient_redis_trips_in_database(LONG_EMA_PERIOD)
    if sufficient_redis_trips_in_database( LONG_EMA_PERIOD + SIGNAL_LINE_PERIOD )
      calculate_signal_line
      calculate_histogram
    end
  end

  def calculate_short_ema
    if first_time_calculating_field(SHORT_EMA_PERIOD)
      self.short_ema = caluculate_ema(SHORT_EMA_PERIOD, 'tweet_count')
    else
      sc = smoothing_constant(SHORT_EMA_PERIOD)
      last_ema = search_term_trips_ordered_by_create.first.short_ema
      self.short_ema = last_ema + sc * ( self.tweet_count - last_ema )
    end
  end

  def calculate_long_ema
    if first_time_calculating_field(LONG_EMA_PERIOD)
      self.long_ema = caluculate_ema(LONG_EMA_PERIOD, 'tweet_count')
    else
      sc = smoothing_constant(LONG_EMA_PERIOD)
      last_ema = search_term_trips_ordered_by_create.first.long_ema
      self.long_ema = last_ema + sc * ( self.tweet_count - last_ema )
    end
  end

  def calculate_macd
    self.macd = self.short_ema - self.long_ema
  end

  def calculate_signal_line
    if first_time_calculating_field(LONG_EMA_PERIOD + SIGNAL_LINE_PERIOD)
      self.signal_line = caluculate_ema(SIGNAL_LINE_PERIOD, 'macd')
    else
      sc = smoothing_constant(SIGNAL_LINE_PERIOD)
      last_signal_line = search_term_trips_ordered_by_create.first.signal_line
      self.signal_line = last_signal_line + sc * ( self.macd - last_signal_line )
    end
  end

  def calculate_histogram
    self.histogram = self.macd - self.signal_line
  end
end
