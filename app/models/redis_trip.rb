class RedisTrip < ActiveRecord::Base
 
  validates :time, presence: true

  before_create :populate_algorithm_fields

  def populate_algorithm_fields
    
  end

  def calculate_short_ema
    sc = smoothing_constant(n)
    RedisTrip.order_by()
  end

  def calculate_long_ema
  end

  def calculate_macd
  end

  def calculate_signal_line
  end

  def smoothing_constant(n)  #extract to helper
    2.0 / (n + 1)
  end

end
