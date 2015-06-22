class Timeline

  def initialize
    @tweets = []
  end

  def make_tweets
    timeline = []

    timeline = current_user.twitter.home_timeline(:count => 199)
    last_id = timeline.last.id - 1

    2.times do
      sleep(1)
      timeline = timeline + current_user.twitter.home_timeline(:count => 199, :max_id => last_id)
      last_id = timeline.last.id - 1
    end

    timeline.each do |tweet_obj|
      @tweets << TimelinePost.new(tweet_obj)
    end
  end



end
