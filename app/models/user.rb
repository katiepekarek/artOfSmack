class User < ActiveRecord::Base
  has_many :tweets

  def self.find_or_create_with_omniauth(auth)
    user = where(provider: auth["provider"], uid: auth["uid"]).first_or_create
    user.update(
      provider: auth.provider,
      uid: auth["uid"],
      name: auth.info.name,
      image: auth['info']['image'],
      nickname: auth['info']['nickname'],
      oauth_token: auth.credentials.token,
      oauth_secret: auth.credentials.secret
    )
    user
  end

  def twitter
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = Rails.application.secrets.twitter_api_key
      config.consumer_secret     = Rails.application.secrets.twitter_api_secret
      config.access_token        = oauth_token
      config.access_token_secret = oauth_secret
    end
  end
end
