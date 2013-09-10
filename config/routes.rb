SportsSpike::Application.routes.draw do

  root 'events#app'
  resources :events, only: [:index]
  resources :redis_trips, only: [:index]

end
