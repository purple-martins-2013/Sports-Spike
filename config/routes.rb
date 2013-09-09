SportsSpike::Application.routes.draw do

  root 'events#index'
  resources :events, only: [:index]
  resources :redis_trips, only: [:index]

end
