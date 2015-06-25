class BleacherReportController < ApplicationController
  before_action :authenticate_user!

  def create
    bleacher_response = BleacherApi::Authenticate.login(params['email'], params['password'])
    if logged_in_to_bleacher_report?
      updated = current_user.update_user_with_bleacher_report(bleacher_response)
      if updated
        #user = User.find_or_create_with_bleacher_report(bleacher_response)
        redirect_to user_omniauth_authorize_path(:twitter), :notice => "Signed in with Bleacher Report!"
      else
        redirect_to sign_in_path, :notice => "Please Check to make sure your Bleacher Report email/password are correct."
      end
    end
  end

private

  def logged_in_to_bleacher_report?
    bleacher_response["id"].present?
  end




end
