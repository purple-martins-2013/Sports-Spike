class SearchTermsController < ApplicationController

  def index
  end
  
  def show
    unless request.xhr?
      trips = RedisTrip.where(search_term_id: params[:id])
      @team_name = trips.first.search_term.hashtag
      render :show
      return
    end
    Time.zone="US/Pacific"
    data = RedisTrip.where(search_term_id: params[:id]).order("created_at DESC").map do |trip|
      formatted_date = trip.created_at.strftime("%Y-%m-%d %I:%M %p")
      [formatted_date, trip.tweet_count]
    end
    render :json => data.sort_by { |d| DateTime.parse(d[0]) }
  end
end
