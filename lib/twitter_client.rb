class TwitterClient

  def initialize(auth)
    @oauth_token, @oauth_secret = auth
  end

  def tweet(text)
    client.update(text)
  end

  def recent_timeline
    client.home_timeline(:count => 149).map do |event|
      klass = parse_type(event.class)
      event.class.send(:define_method, :class_name) do
        klass
      end
      event
    end
  end

private

  def client
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV.fetch("TWITTER_API_KEY")
      config.consumer_secret     = ENV.fetch("TWITTER_API_SECRET")
      config.access_token        = @oauth_token
      config.access_token_secret = @oauth_secret
    end
  end

  def parse_type(klass)
    klass.to_s.sub("Twitter::","")
  end
end
