SportsSpike::Application.routes.draw do

  root 'events#index'
  resources :events, only: [:index]
  resources :tweets, only: [:index]

end
