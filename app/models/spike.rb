class Spike < ActiveRecord::Base
  belongs_to :redis_trip
  before_create :get_game_status

  NFL_LIB = {
  "#Ravens" => "bal",
  "#Patriots" => "ne",
  "#Bengals" => "cin",
  "#Dolphins" => "mia",
  "#Raiders" => "oak",
  "#Chiefs" => "kc",
  "#Bucs" => "tb",
  "#Titans" => "ten",
  "#Falcons" => "atl",
  "#Seahawks" => "sea",
  "#Vikings" => "min",
  "#Packers" => "gb",
  "#Cardinals" => "ari",
  "#Giants" => "nyg",
  "#Eagles" => "phi",
  "#Texans" => "hou",
  "#Jets" => "nyj",
  "#Cowboys" => "dal",
  "#Rams" => "stl",
  "#Chargers" => "sd",
  "#Panthers" => "car",
  "#Browns" => "cle",
  "#Redskins" => "wsh",
  "#Saints" => "no",
  "#Lions" => "det",
  "#Jaguars" => "jac",
  "#Broncos" => "den",
  "#49ers" => "sf",
  "#Steelers" => "pit",
  "#Colts" => "ind",
  "#Bills" => "buf",
  "#Bears" => "chi"
  }

  NFL_CALENDAR = [
    [1, "Tue, 10 Sep 2013"], 
    [2, "Tue, 17 Sep 2013"], 
    [3, "Tue, 24 Sep 2013"], 
    [4, "Tue, 01 Oct 2013"], 
    [5, "Tue, 08 Oct 2013"], 
    [6, "Tue, 15 Oct 2013"], 
    [7, "Tue, 22 Oct 2013"], 
    [8, "Tue, 29 Oct 2013"], 
    [9, "Tue, 05 Nov 2013"], 
    [10, "Tue, 12 Nov 2013"], 
    [11, "Tue, 19 Nov 2013"], 
    [12, "Tue, 26 Nov 2013"], 
    [13, "Tue, 03 Dec 2013"], 
    [14, "Tue, 10 Dec 2013"], 
    [15, "Tue, 17 Dec 2013"], 
    [16, "Tue, 24 Dec 2013"], 
    [17, "Tue, 31 Dec 2013"]
  ]

  private

  def get_game_status
    get_search_term
    nfl_week
    ESPN.get_nfl_scores(Date.today.year, @week).each do |game|
      self.game_status = game[:status] if game[:home_team] == @abbr || game[:away_team] == @abbr
    end 
  end

  def nfl_week
    NFL_CALENDAR.each do |week, date|
      @week = week if (Date.today - date.to_date) >= 0 && (Date.today - date.to_date) < 7
    end 
  end

  def get_search_term
    team = self.redis_trip.search_term.hashtag
    NFL_LIB.each do |hashtag, abbreviation|
      @abbr = abbreviation if team == hashtag
    end
  end
end
