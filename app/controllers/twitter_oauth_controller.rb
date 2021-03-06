class TwitterOauthController < ApplicationController

  def create
    auth = request.env["omniauth.auth"]
    user = User.find_or_create_with_omniauth(auth)
    session[:user_id] = user.id
    redirect_to welcome_index_path, :notice => "Signed in with Twitter!"
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Signed out!"
  end


end
