Rails.application.routes.draw do
  root to: redirect("/products")
  resources :products, only: [:index]
  resources :search_log, only: [:index]
end
