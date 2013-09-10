class RedisTrip < ActiveRecord::Base
  has_one :spike
  belongs_to :search_term
  
  acts_as_reportable

  SIGNAL_LINE_PERIOD = 2
  SHORT_EMA_PERIOD = 4
  LONG_EMA_PERIOD = 8

  before_create :populate_algorithm_fields

  # TODO: CLEAN UP THIS UGLY CODE~!!!!!!!


  def populate_algorithm_fields
    calculate_short_ema if RedisTrip.where("search_term_id = #{self.search_term_id}").count > SHORT_EMA_PERIOD
    calculate_long_ema if RedisTrip.where("search_term_id = #{self.search_term_id}").count > LONG_EMA_PERIOD
    calculate_macd if RedisTrip.where("search_term_id = #{self.search_term_id}").count > LONG_EMA_PERIOD
    if RedisTrip.where("search_term_id = #{self.search_term_id}").count > LONG_EMA_PERIOD + SIGNAL_LINE_PERIOD
      calculate_signal_line
      calculate_histogram
    end
    # calculate_signal_line if RedisTrip.where("search_term_id = #{self.search_term_id}").count > LONG_EMA_PERIOD + SIGNAL_LINE_PERIOD
  end

  def calculate_short_ema
    if RedisTrip.where("search_term_id = #{self.search_term_id}").size == SHORT_EMA_PERIOD + 1
      # self.short_ema = RedisTrip.where("search_term_id = #{self.search_term_id}").pluck('tweet_count').inject(:+) / SHORT_EMA_PERIOD
      self.short_ema = RedisTrip.order('created_at DESC').limit(SHORT_EMA_PERIOD).pluck('tweet_count').inject(:+) / SHORT_EMA_PERIOD
    elsif RedisTrip.where("search_term_id = #{self.search_term_id}").size > SHORT_EMA_PERIOD + 1
      sc = smoothing_constant(SHORT_EMA_PERIOD)
      last_ema = RedisTrip.order('created_at DESC').first.short_ema
      self.short_ema = last_ema + sc * ( self.tweet_count - last_ema )
    end
  end

  def calculate_long_ema
    if RedisTrip.where("search_term_id = #{self.search_term_id}").size == LONG_EMA_PERIOD + 1
      # self.long_ema = RedisTrip.where("search_term_id = #{self.search_term_id}").pluck('tweet_count').inject(:+) / LONG_EMA_PERIOD
      self.long_ema = RedisTrip.order('created_at DESC').limit(LONG_EMA_PERIOD).pluck('tweet_count').inject(:+) / LONG_EMA_PERIOD
    elsif RedisTrip.where("search_term_id = #{self.search_term_id}").size > LONG_EMA_PERIOD + 1
      sc = smoothing_constant(LONG_EMA_PERIOD)
      last_ema = RedisTrip.order('created_at DESC').first.long_ema
      self.long_ema = last_ema + sc * ( self.tweet_count - last_ema )
    end
  end

  def calculate_macd
    self.macd = self.short_ema - self.long_ema
  end

  def calculate_signal_line
    if RedisTrip.where("search_term_id = #{self.search_term_id}").size == LONG_EMA_PERIOD + SIGNAL_LINE_PERIOD + 1
      self.signal_line = RedisTrip.order('created_at DESC').limit(SIGNAL_LINE_PERIOD).pluck('macd').inject(:+) / SIGNAL_LINE_PERIOD 
    elsif RedisTrip.where("search_term_id = #{self.search_term_id}").size > LONG_EMA_PERIOD + SIGNAL_LINE_PERIOD + 1
      sc = smoothing_constant(SIGNAL_LINE_PERIOD)
      last_signal_line = RedisTrip.order('created_at DESC').first.signal_line
      self.signal_line = last_signal_line + sc * ( self.macd - last_signal_line )
    end
  end

  def calculate_histogram
    self.histogram = self.macd - self.signal_line
  end

  def smoothing_constant(n)  #extract to helper
    2.0 / (n + 1)
  end
end
