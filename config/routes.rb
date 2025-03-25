Rails.application.routes.draw do
  root 'products#index'

  resources :products, only: [:index]

  resource :cart, only: [:show] do
    post :add_product
    delete :remove_item
  end
  
end
