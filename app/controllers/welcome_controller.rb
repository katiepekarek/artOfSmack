class WelcomeController<ApplicationController
  def index
    @tweets = Tweet.all
    @tweet = Tweet.new
  end

end
