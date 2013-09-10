SportsSpike::Application.routes.draw do

  root 'redis_trips#index'
  resources :events, only: [:index]
  resources :redis_trips, only: [:index]

  get 'redis_trips/:search_term_id' => 'redis_trips#team_pulse'

end
