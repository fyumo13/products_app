class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :require_login
  helper_method :current_user, :logged_in?

  def current_user
    User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    current_user != nil
  end

  private
    def require_login
      unless logged_in?
        flash[:error] = "You must be logged in to access this."
        redirect_to "/sessions/new"
      end
    end
end
