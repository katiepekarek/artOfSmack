class WelcomeController<ApplicationController
  def index
    if current_user
      @recent_timeline = current_user.twitter_events
    end
  end

end
