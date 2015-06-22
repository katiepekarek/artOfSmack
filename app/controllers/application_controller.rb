class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def is_authenticated?
      if current_user and !current_user[:id].nil? and !session[:id].nil? and current_user[:id] == session[:id]
        true
      else
        false
      end
    end
end
