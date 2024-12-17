class ApplicationController < ActionController::Base

  helper_method :current_user, :logged_in?
  before_action :set_current_user

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def logged_in?
    current_user.present?
  end

  def require_login
    unless logged_in?
      redirect_to signup_path, alert: "Please sign up or log in to continue"
    end
  end

  private

  def set_current_user
    @user = current_user
  end
end
  