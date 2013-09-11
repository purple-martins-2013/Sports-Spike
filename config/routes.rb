SportsSpike::Application.routes.draw do

  root 'redis_trips#teams'
  resources :events, only: [:index]
  resources :redis_trips, only: [:index] 
  

  resources :search_terms, only: [:show]

  get '/:search_term_id', to: 'redis_trips#team_pulse', as: 'team_pulse'

end
