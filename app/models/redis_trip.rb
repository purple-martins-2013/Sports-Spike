class RedisTrip < ActiveRecord::Base
  SIGNAL_LINE_PERIOD = 3
  SHORT_EMA_PERIOD = 5
  LONG_EMA_PERIOD = 10
 
  validates :time, presence: true

  before_create :populate_algorithm_fields

  private

  # TODO: CLEAN UP THIS UGLY CODE~!!!!!!!

  def populate_algorithm_fields
    calculate_short_ema if RedisTrip.all.count > SHORT_EMA_PERIOD
    calculate_long_ema if RedisTrip.all.count > LONG_EMA_PERIOD
    calculate_macd if RedisTrip.all.count > LONG_EMA_PERIOD
    calculate_signal_line if RedisTrip > LONG_EMA_PERIOD + SIGNAL_LINE_PERIOD
  end

  def calculate_short_ema
    self.short_ema = RedisTrip.all.pluck('tweet_count').inject(:+) / SHORT_EMA_PERIOD if RedisTrip.all.size == SHORT_EMA_PERIOD + 1
    sc = smoothing_constant(SHORT_EMA_PERIOD)
    last_ema = RedisTrip.order('created_at DESC').first.short_ema
    self.short_ema = last_ema + sc * ( self.tweet_count - last_ema )
  end

  def calculate_long_ema
    self.long_ema = RedisTrip.all.pluck('tweet_count').inject(:+) / LONG_EMA_PERIOD if RedisTrip.all.size == SHORT_EMA_PERIOD + 1
    sc = smoothing_constant(LONG_EMA_PERIOD)
    last_ema = RedisTrip.order('created_at DESC').first.long_ema
    self.long_ema = last_ema + sc * ( self.tweet_count - last_ema )
  end

  def calculate_macd
    self.macd = self.short_ema - self.long_ema
  end

  def calculate_signal_line
    self.signal_line = RedisTrip.order('created_at DESC').limit(3).pluck('macd').inject(:+) / SIGNAL_LINE_PERIOD if RedisTrip.all.size == SIGNAL_LINE_PERIOD + 1
    sc = smoothing_constant(SIGNAL_LINE_PERIOD)
    last_signal_line = RedisTrip.order('created_at DESC').first.signal_line
    self.signal_line = last_signal_line + sc * ( self.macd - last_signal_line )
  end

  def smoothing_constant(n)  #extract to helper
    2.0 / (n + 1)
  end

end
