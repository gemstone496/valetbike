Rails.application.routes.draw do
  get 'stations/index'
  get 'bikes/index'
  get 'bikes/_row'
  get 'main/pricing'
  get 'main/account'
  get 'main/contact'



  root to: "main#index"
end