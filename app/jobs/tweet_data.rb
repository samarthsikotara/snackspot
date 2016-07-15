class ::TweetData

  @queue = :tweet_data

  def self.perform(data)
  	data.each do |tweet|
  		lat = (tweet["geo"]["coordinates"][0] rescue 0.0); lng = (tweet["geo"]["coordinates"][1] rescue 0.0)
  		Tweet.create(:tweet_id => tweet["id"], :tweet_created_at => tweet["created_at"], :name => tweet["user"]["name"], :profile_pic_url => tweet["user"]["profile_image_url"], :screen_name => tweet["user"]["screen_name"], :location => tweet["user"]["location"], :tweets_count => tweet["user"]["statuses_count"], :followers_count => tweet["user"]["followers_count"], :following_count => tweet["user"]["friends_count"], :location_lat => lat, :location_lng => lng)
  	end
  end
end
