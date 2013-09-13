class SearchTermsController < ApplicationController



  def show
    @team_one_id = params[:team_one]
    @team_two_id = params[:team_two]
    team_one_trips = RedisTrip.where(search_term_id: params[:team_one])
    team_two_trips = RedisTrip.where(search_term_id: params[:team_two])

    unless request.xhr?
      @team_one_name = team_one_trips.first.search_term.hashtag
      @team_two_name = team_two_trips.first.search_term.hashtag
      render :show
      return
    end

    Time.zone="US/Pacific"
    team_one_data = team_one_trips.order("created_at DESC").map do |trip|
      formatted_date = trip.created_at.strftime("%Y-%m-%d %I:%M %p")
      [formatted_date, trip.tweet_count]
    end

    team_two_data = team_two_trips.order("created_at DESC").map do |trip|
      formatted_date = trip.created_at.strftime("%Y-%m-%d %I:%M %p")
      [formatted_date, trip.tweet_count]
    end

    fan_pulse_team_one, fan_pulse_team_two = [], []
    if team_one_trips.last.histogram >= 0
      fan_pulse_team_one << team_one_trips.last.histogram
    else 
      fan_pulse_team_one << 0
    end

    if team_two_trips.last.histogram >= 0
      fan_pulse_team_two << team_two_trips.last.histogram
    else
      fan_pulse_team_two << 0
    end
    
    tweets_by_team_one = team_one_data.sort_by { |d| DateTime.parse(d[0]) }
    tweets_by_team_two = team_two_data.sort_by { |d| DateTime.parse(d[0]) }

    render :json => { fan_pulse_team_one: fan_pulse_team_one, fan_pulse_team_two: fan_pulse_team_two, tweets_by_team_one: tweets_by_team_one, tweets_by_team_two: tweets_by_team_two }
  end
end
