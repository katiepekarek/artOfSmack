class BleacherReportsController < ApplicationController
  before_action :authenticate_user!

  def create
    bleacher_response = BleacherApi::Authenticate.login(params['email'], params['password'])
    if bleacher_response["id"].present?
      byebug
      if current_user.update_user_with_bleacher_report(bleacher_response)
        redirect_to "/auth/twitter", :notice => "Signed in with Bleacher Report!"
      else
        redirect_to :back, :notice => "Please Check to make sure your Bleacher Report email/password are correct."
      end
    end
  end

private


end
