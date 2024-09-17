Rails.application.routes.draw do
  get 'bikes/index'
  get 'bikes/_row'
  root to: "stations#index"
end