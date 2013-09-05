SportsSpike::Application.routes.draw do
  resources :spikes, only: [:index]
end
