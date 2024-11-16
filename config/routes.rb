Rails.application.routes.draw do
  get 'stations/index'
  get 'stations/show'
  get 'bikes/index'
  get 'bikes/_row'
  get 'main/pricing'
  get 'main/contact'


  get 'trip/confirmation'


  # resources :bikes
  # resources :stations
    resources :stations, only: [:index, :show] do
      resources :bikes, only: [:index, :show]
    end

  resources :trips, except: [:destroy]

  get "sign-up", to: "user#new"
  post "sign-up", to: "user#create"

  get "log-in", to: "access#login"
  post "log-in", to: "access#create"
  post "log-out", to: "access#destroy"

  get "password/reset", to: "password_resets#new"
  post "password/reset", to: "password_resets#create"
  get "password/reset/edit", to: "password_resets#edit"
  patch "password/reset/edit", to: "password_resets#update"

  resources :account, only: [:index, :destroy]

  root to: "main#index"
end