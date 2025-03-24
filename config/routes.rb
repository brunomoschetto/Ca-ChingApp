Rails.application.routes.draw do
  get 'products/index'
  get "up" => "rails/health#show", as: :rails_health_check

  resources :products, only: [:index]
end
