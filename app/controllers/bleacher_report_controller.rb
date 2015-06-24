class BleacherReportController < ApplicationController

  def new
  end

  def create
    bleacher_response = BleacherApi::Authenticate.login(params['email'], params['password'])
    user = User.find_or_create_with_bleacher_report(bleacher_response)
    if bleacher_response
      session[:user_id] = user.id
      redirect_to root_url, :notice => "Signed in with Bleacher Report!"
    else
      redirect_to sign_in_path, :notice => "Please Check to make sure your Bleacher Report email/password are correct."
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Signed out!"
  end

end
