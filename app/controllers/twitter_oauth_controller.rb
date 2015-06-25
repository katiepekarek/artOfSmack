class TwitterOauthController < ApplicationController
  before_action :authenticate_user!
  def create
    auth = request.env["omniauth.auth"]
    user = User.find_or_create_with_omniauth(auth)
    redirect_to root_url, :notice => "Signed in with Twitter!"
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Signed out!"
  end


end
