class RedisTripsController < ApplicationController
 
  def index
   @trips = RedisTrip.all
    @teams = SearchTerm.all
  end

  def render_data
    Time.zone="US/Pacific"
    data = RedisTrip.where(search_term_id: 15).order("created_at DESC").map do |trip|
      formatted_date = trip.created_at.strftime("%Y-%m-%d %I:%M %p")
      [formatted_date, trip.tweet_count]

    end
    render :json => data.sort_by { |d| DateTime.parse(d[0]) }
  end

  def team_pulse
    @trips = RedisTrip.where(search_term_id: params[:search_term_id])
    @team_name = @trips.first.search_term.hashtag
  end
end
