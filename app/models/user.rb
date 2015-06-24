class User < ActiveRecord::Base
  has_many :tweets
  has_many :twitter_events

  def self.find_or_create_with_omniauth(auth)
    user = where(provider: auth["provider"], uid: auth["uid"], name: auth.info.name).first_or_create
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

  def self.find_or_create_with_bleacher_report(bleacher_response)
    user = where(bleacher_id: bleacher_response["id"]).first_or_create
    user.update(
      bleacher_id: bleacher_response["id"],
      name: bleacher_response["full_name"],
      email: bleacher_response["email"],
      teams: bleacher_response["api"]["teams"]
    )
    user
  end

  serialize :teams

  def timeline
    @timeline = if twitter_events.none?
      t = Twitter.new([oauth_token, oauth_secret])
      cache_recent_timeline(events)
     else
      twitter_events
     end
  end

  def cache_recent_timeline(events)
    events.each do |event|
      twitter_events.create(type: event.class_name,
                      text: event.text, username: event.user.username, handle: event.user.handle, hashtags: event.hashtags.map(&:text).join(","))
    end
  end

end
