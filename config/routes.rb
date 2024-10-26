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
end
