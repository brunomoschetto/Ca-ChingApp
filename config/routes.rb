Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  resources :products, only: [:index]

  resources :carts, only: [:show, :create] do
    member do
      post 'add_product'
    end
  end
  
end
