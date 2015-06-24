class WelcomeController<ApplicationController
  def index
    if current_user && current_user.provider == "twitter"
      @recent_timeline = current_user.timeline
    end
  end

end
