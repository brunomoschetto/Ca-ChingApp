Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  resources :products, only: [:index]
  resource :cart, only: [:show] do
    post :add_product
  end
end
