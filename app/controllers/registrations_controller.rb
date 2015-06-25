class RegistrationsController < Devise::RegistrationsController
  protected

  def after_sign_up_path_for(bleacher_report)
    '/sign-in'
  end

  def after_inactive_sign_up_path_for(bleacher_report)
    'https://bleacherreport.com/login'
  end
end
