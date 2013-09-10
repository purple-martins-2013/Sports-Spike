class RedisTripsController < ApplicationController
 
  def index
  end

  def render_data
    Time.zone="US/Pacific"
    data = RedisTrip.where(search_term_id: 2).order("created_at DESC").map do |trip|
      formatted_date = trip.created_at.strftime("%Y-%m-%d %I:%M")
      [formatted_date, trip.tweet_count]
    end
    puts ('#') * 50
    p data
    render :json => data.sort_by { |d| DateTime.parse(d[0]) }
  end
end
