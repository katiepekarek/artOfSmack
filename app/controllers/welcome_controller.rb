class WelcomeController<ApplicationController
  def index
    @tweets = Tweet.all
    @tweet = Tweet.new
    #@timeline_posts = (Timeline.new).make_tweets
  end

end
