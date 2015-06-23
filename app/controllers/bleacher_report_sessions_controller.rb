class BleacherReportSessionsController < ApplicationController

  def create
    bleacher_response = BleacherApi::Authenticate.login(params['email'], params['password'])
    user = User.find_by(bleacher_response[:bleacher_id], bleacher_response[:email]) || User.create_with_omniauth(auth)
    bleacher_response = BleacherApi::Authenticate.login(params['email'], params['password'])

    unless bleacher_response
      redirect_to sign_in_path, :notice => "Please Check to make sure your Bleacher Report email/password are correct."
    end

    user = User.find_by(params[:user_id], params[:bleacher_id]) || User.create_with_bleacher_report(bleacher_response)
    session[:user_id] = user.id
    redirect_to root_url, :notice => "Signed in!"
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Signed out!"
  end

end
