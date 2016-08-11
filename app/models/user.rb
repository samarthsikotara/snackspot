class User < ActiveRecord::Base
	
  def tweet(tweet = "", tweet_id=nil)
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = Rails.application.config.twitter_key
      config.consumer_secret     = Rails.application.config.twitter_secret
      config.access_token        = self.oauth_token
      config.access_token_secret = self.oauth_secret
    end
    client.retweet(tweet_id) rescue nil
    #client.update(tweet)
  end
end
