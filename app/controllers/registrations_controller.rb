class RegistrationsController < Devise::RegistrationsController
  protected

  def after_sign_up_path_for(resource)
    new_bleacher_report_path
  end

  def after_inactive_sign_up_path_for(bleacher_report)
    'https://bleacherreport.com/login'
  end
end
