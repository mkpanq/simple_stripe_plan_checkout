Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  # Session controller
  get "login" => "session#new"
  post "login" => "session#create"
  delete "logout" => "session#delete"

  # Dashboard controller
  get "/" => "dashboard#home", as: :root
end
