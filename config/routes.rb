SportsSpike::Application.routes.draw do

  root 'tweets#index'
  resources :events, only: [:index]

end
