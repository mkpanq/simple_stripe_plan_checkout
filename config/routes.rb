Rails.application.routes.draw do
  require "sidekiq/web"

  get "up" => "rails/health#show", as: :rails_health_check
  mount Sidekiq::Web => "/sidekiq"

  # Session controller
  get "login" => "session#new"
  post "login" => "session#create"
  delete "logout" => "session#delete"

  # Dashboard controller
  get "/" => "dashboard#home", as: :root
  post "/refresh_bundles" => "dashboard#refresh_bundles", as: :refresh_bundles

  # Checkout controller
  post "/checkout" => "checkout#get_checkout", as: :checkout
  post "/checkout_status" => "checkout#checkout_status"
  get "/success" => "checkout#success_status", as: :success
  get "/cancel" => "checkout#cancel_status", as: :cancel

  # Orders controller
  get "/orders" => "orders#index", as: :orders
end
