module TweetsHelper
  

  def pretty_tweet(tweet_obj)
    html = "<blockquote class=\"twitter-tweet\" align=\"left\" lang=\"en\"><p>"
    html = html + "</p>&mdash; #{tweet_obj.user_name} (@#{tweet_obj.user_handle}) <a href=\"#{tweet_obj.tweet_url}\">#{tweet_obj.created_at.strftime("%m/%d/%y")}</a></blockquote>"
    return html.html_safe
  end

end
