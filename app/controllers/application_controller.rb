class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def application
  	@nfl_teams =SearchTerm.all
  end
end
