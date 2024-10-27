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
  post "/checkout_new" => "checkout#create_new_checkout_session", as: :checkout_new
  post "/checkout_continue" => "checkout#continue_existing_checkout_session", as: :checkout_continue
  post "/checkout_status" => "checkout#checkout_status", as: :checkout_status
  get "/success" => "checkout#success_status", as: :success
  get "/cancel" => "checkout#cancel_status", as: :cancel

  # Orders controller
  get "/orders" => "orders#index", as: :orders
end
