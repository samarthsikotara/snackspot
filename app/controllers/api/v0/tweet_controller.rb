module Api::V0
	class TweetController < ::ApiController
		
		include WelcomeHelper

		def tweets
			return render json: {:message => "Unable to get current location. please check your internet"}, status: 400 unless params[:lat] && params[:lng]
			geo_data = tweet_data(params[:lat], params[:lng])
			#data = geo_data["statuses"].map { |data| {:name => data["user"]["name"], :description => data["user"]["description"], :screen_name => data["user"]["screen_name"], :latitude => data["geo"]["coordinates"][0], :longitude => data["geo"]["coordinates"][1], :profile_pic_url => data["user"]["profile_image_url"], :profile_background_image_url => data["user"]["profile_background_image_url"] , :tweets => {:id => data["id"], :text => data["text"], :created_at => data["created_at"]}} unless data["geo"].nil? }.compact
			data = geo_data["statuses"].map do |tweet|
				unless tweet["geo"].nil?
					{
						:id => tweet["user"]["id"],
						:name => tweet["user"]["name"],
						:gender => get_gender(tweet["user"]["name"]),
						:description => tweet["user"]["description"], 
						:screen_name => tweet["user"]["screen_name"], 
						:latitude => tweet["geo"]["coordinates"][0], 
						:longitude => tweet["geo"]["coordinates"][1], 
						:profile_pic_url => tweet["user"]["profile_image_url"], 
						:profile_background_image_url => tweet["user"]["profile_background_image_url"], 
						:followers_count => tweet["user"]["followers_count"],
						:tweets_count => tweet["user"]["statuses_count"],
						:following_count => tweet["user"]["friends_count"],
						:retweet_count => tweet["retweet_count"],
						:favorite_count => tweet["favorite_count"],
						:tweet => {
							:id => tweet["id"], 
							:text => tweet["text"], 
							:created_at => Time.zone.parse(tweet["created_at"].to_s)
						}
					}
				end
			end
			render json: {:data => data.compact}, status: 200	
		end

	end
end