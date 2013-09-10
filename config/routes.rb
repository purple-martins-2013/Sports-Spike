SportsSpike::Application.routes.draw do

  root 'redis_trips#index'
  resources :events, only: [:index]
  resources :redis_trips, only: [:index] do
    collection do
      get 'render_data'
    end
  end

end
