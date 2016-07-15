module Api::V0
	class TweetController < ::ApiController
		
		include WelcomeHelper

		def tweets
			return render json: {:message => "Unable to get current location. please check your internet"}, status: 400 unless params[:lat] && params[:lng]
			geo_data = tweet_data(params[:lat], params[:lng])
			tweets = geo_data["statuses"].map do |tweet|
				unless tweet["geo"].nil?
					{
						:id => tweet["id"],
						:user_id => tweet["user"]["id"], 
						:profile_pic_url => tweet["user"]["profile_image_url"],
						:text => tweet["text"], 
						:created_at => Time.zone.parse(tweet["created_at"].to_s).to_i,
						:retweet_count => tweet["retweet_count"],
						:favorite_count => tweet["favorite_count"],
						:reply_url => "https://twitter.com/"+tweet["user"]["screen_name"].to_s+'/status/'+tweet["id"].to_s
					}
				end
			end
			people = geo_data["statuses"].map do |tweet|
				unless tweet["geo"].nil?
					{
						:id => tweet["user"]["id"],
						:name => tweet["user"]["name"],
						:description => tweet["user"]["description"], 
						:screen_name => tweet["user"]["screen_name"],
						:gender => (get_gender(tweet["user"]["name"])["gender"] rescue ""),
						:profile_url => 'https://twitter.com/'+tweet["user"]["screen_name"].to_s, 
						:latitude => tweet["geo"]["coordinates"][0], 
						:longitude => tweet["geo"]["coordinates"][1], 
						:profile_pic_url => tweet["user"]["profile_image_url"], 
						:profile_background_image_url => tweet["user"]["profile_background_image_url"], 
						:followers_count => tweet["user"]["followers_count"],
						:tweets_count => tweet["user"]["statuses_count"],
						:following_count => tweet["user"]["friends_count"],
						:created_at => Time.zone.parse(tweet["created_at"].to_s).to_i,
					}
				end
			end
			people = people.compact.uniq!{|e| e[:id]}
			render json: {:data => {:tweets => tweets.compact.sort_by { |k| k["created_at"]}, :people => people.sort_by { |k| k["created_at"]}}}, status: 200	
		end

	end
end