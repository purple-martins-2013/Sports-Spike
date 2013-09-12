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
    params[:chap] = [2,17]
    team_one_data = RedisTrip.where(search_term_id: params[:chap][0]).order("created_at DESC").map do |trip|
      formatted_date = trip.created_at.strftime("%Y-%m-%d %I:%M %p")
      [formatted_date, trip.tweet_count]
    end
    team_two_data = RedisTrip.where(search_term_id: params[:chap][1]).order("created_at DESC").map do |trip|
      formatted_date = trip.created_at.strftime("%Y-%m-%d %I:%M %p")
      [formatted_date, trip.tweet_count]
    end
    fan_pulse_team_one = []
      fan_pulse_team_one << RedisTrip.where(search_term_id: params[:chap][0]).last.histogram
    fan_pulse_team_two = []
      fan_pulse_team_two << RedisTrip.where(search_term_id: params[:chap][1]).last.histogram
    p fan_pulse_team_two
    
    tweets_by_team_one = team_one_data.sort_by { |d| DateTime.parse(d[0]) }
    tweets_by_team_two = team_two_data.sort_by { |d| DateTime.parse(d[0]) }
    render :json => { fan_pulse_team_one: fan_pulse_team_one, fan_pulse_team_two: fan_pulse_team_two,  tweets_by_team_one: tweets_by_team_one, tweets_by_team_two: tweets_by_team_two }
  end
end
