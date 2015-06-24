class TwitterOauthController < ApplicationController

  def create
    auth = request.env["omniauth.auth"]
    current_user = User.find_or_create_with_omniauth(auth)
    session[:user_id] = current_user.id
    redirect_to root_url, :notice => "Signed in!"
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Signed out!"
  end


end
