class SessionController < ApplicationController
  skip_before_action :authorize, only: [ :new, :create ]

  def new
    redirect_to root_path if is_logged_in?
  end

  def create
    session[:current_user_id] = User.first.id
    redirect_to root_path
  end

  def delete
    session[:current_user_id] = nil
    redirect_to login_path
  end
end
