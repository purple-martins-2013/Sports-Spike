class Spike < ActiveRecord::Base
  belongs_to :redis_trip
  

  def time_since_game_start
    self.date_time.time - self.event.date.time
  end
  
end
