class TimelinePost
  attr_reader :tweet_id, :text, :user_name, :user_handle,
              :tweet_hashtags, :created_at

  def initialize(tweet_obj)
    @tweet_id = tweet_obj.id
    @text = tweet_obj.text
    @user_name = tweet_obj.user.name
    @user_handle = tweet_obj.user.handle.each { |tag| puts tag }
    @tweet_hashtags = tweet_obj.hashtags
    @created_at = tweet_obj.created_at
  end

end
