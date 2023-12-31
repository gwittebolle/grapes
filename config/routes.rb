Rails.application.routes.draw do
  devise_for :users
  root to: "wines#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  resources :wines, only: %i[index show new create destroy edit update] do
    resources :bookings, only: %i[new create]
  end
  get 'profile', action: :show, controller: 'dashboards'


  resources :bookings, only: :destroy
  resources :roulettes, only: :index

  resources :bookings do
    member do
      patch 'validate'
      patch 'deliver'
      patch 'reject'
    end
  end

  get "notifications", to: "notifications#index"

end
