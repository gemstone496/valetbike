Rails.application.routes.draw do
  get 'bikes/index'
  get 'bikes/_row'

  get "sign-up", to: "user#new"
  post "sign-up", to: "user#create"
  root to: "stations#index"
end