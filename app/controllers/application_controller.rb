class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :authorize
  helper_method :current_user
  helper_method :is_logged_in

  private

  def authorize
    redirect_to login_path unless is_logged_in?
  end

  def current_user
    @current_user ||= User.find(session[:current_user_id])
  end

  def is_logged_in?
    session[:current_user_id]
  end
end
