require "twitter_client"
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable
  serialize :teams
  has_many :tweets
  has_many :twitter_events

  def update_user_with_bleacher_report(hash)
    update(
      bleacher_id: hash["id"],
      name: hash["full_name"],
      email: hash["email"],
      teams: hash["api"]["teams"]
      #todo -add token auth
    )
  end

  # def signed_in_to_bleacher_report?
  #   #todo use token instead
  #   bleacher_id
  # end
  #
  # def signed_in_to_twitter?
  #   oauth_token && oauth_secret
  # end

#   def self.find_or_create_with_bleacher_report(hash)
#     user = find_or_create_by(bleacher_id: hash["id"])
# binding.pry
#     user.update(
#       name: hash["full_name"],
#       email: hash["email"],
#       teams: hash["api"]["teams"]
#     )
#     user
#   end

  def self.find_or_create_with_omniauth(auth)
    user = where(provider: auth["provider"], uid: auth["uid"]).find_or_create
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

  def self.update_with_session(params, session)
    if session["devise.user_attributes"]
      update(session["devise.user_attributes"], without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end


  def timeline
    @timeline = if twitter_events.none?
      cache_recent_timeline
     else
      twitter_events
     end
  end

  def send_tweet(tweet)
    twitter_client.tweet(tweet)
  end

  def cache_recent_timeline
    twitter_client.recent_timeline.each do |event|
      twitter_events.create(type: event.class_name,
                      text: event.text, username: event.user.username, handle: event.user.handle, hashtags: event.hashtags.map(&:text).join(","))
    end
    twitter_events
  end

  private
    def twitter_client
      @twitter_client ||= ::TwitterClient.new([oauth_token, oauth_secret])
    end

end
