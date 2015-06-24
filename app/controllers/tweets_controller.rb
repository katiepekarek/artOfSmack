class TweetsController<ApplicationController
  def create
    current_user.send_tweet(params[:tweet][:text])
    redirect_to :back
  end

  private
    def set_tweet
      @tweet = Tweet.find(params[:id])
    end

    def tweet_params
      params.require(:tweet).permit(:user_id, :content)
    end
end
