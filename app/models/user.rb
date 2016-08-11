class User < ActiveRecord::Base
	def self.from_omniauth(auth)
    debugger
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.oauth_token = auth.credentials.token
      user.oauth_secret = auth.credentials.secret
      user.save!
    end
  end

  def tweet(tweet = "", tweet_id=nil)
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = Rails.application.config.twitter_key
      config.consumer_secret     = Rails.application.config.twitter_secret
      config.access_token        = self.oauth_token
      config.access_token_secret = self.oauth_secret
    end
    client.retweet(tweet_id)
    #client.update(tweet)
  end
end
