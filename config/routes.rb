Rails.application.routes.draw do
  root to: 'customers#index'
  resources :customers
  resources :orders
  delete "/customers/customerAndOrders/:id", to: "customers#destroy_with_orders"
end
