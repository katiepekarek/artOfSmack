class WelcomeController<ApplicationController
  def index
    @user = BleacherApi::Authenticate.login('thompson.kpk@gmail.com', 'password')
    if current_user
      @recent_timeline = current_user.twitter_events
    end
  end
end
