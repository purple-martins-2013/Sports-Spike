SportsSpike::Application.routes.draw do

  root 'redis_trips#index'
  resources :events, only: [:index]
  resources :redis_trips, only: [:index]
  # resources :search_terms, only: [:show]  

  get 'redis_trips/teams', to: 'redis_trips#teams', as: 'redis_trips_teams'
  get 'team_pulse/:team_one/:team_two', to: 'search_terms#show', as: 'search_term'
end
