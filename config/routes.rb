Rails.application.routes.draw do
  get 'stations/index'
  get 'bikes/index'
  get 'bikes/_row'

  get "sign-up", to: "user#new"
  post "sign-up", to: "user#create"

  get "log-in", to: "access#login"
  post "log-in", to: "access#create"

  get "password/reset", to: "password_resets#new"
  post "password/reset", to: "password_resets#create"
  get "password/reset/edit", to: "password_resets#edit"
  patch "password/reset/edit", to: "password_resets#update"

  root to: "stations#index"
  get 'main/pricing'
  get 'main/account'
  get 'main/contact'



  root to: "main#index"
end