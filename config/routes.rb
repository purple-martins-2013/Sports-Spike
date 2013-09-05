SportsSpike::Application.routes.draw do
  resources :spikes, only: [:index]

  root to: "tweets#index"
end
