class Spike < ActiveRecord::Base
  belongs_to :redis_trip

  def time_since_game_start
    self.date_time.time - self.event.date.time
  end

 def find_hashtag(spike_event_id)
 	redis_trip_id = Spike.find(spike_event_id).reduis_trip_id
 	search_term_id = RedisTrip.find(@redis_trip_id).search_term_id
 	@hashtag = SearchTerm.find(search_term_id).hashtag
 end
 
end
