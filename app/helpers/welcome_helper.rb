module WelcomeHelper

	def tweet_data(lat, lon)
		url = URI("https://api.twitter.com/1.1/search/tweets.json?q=&geocode=#{lat},#{lon},5km&result_type=recent&count=100")
		http = Net::HTTP.new(url.host, url.port);http.use_ssl = true
		headers = {'Authorization' => "Bearer AAAAAAAAAAAAAAAAAAAAADVZvgAAAAAAh6c%2F50%2BA5n5edeyjWyBZ%2F0m1Qd0%3DuNdHwnlEG6nJwjUvbeVEBHtwBt3Wqar8bXJ0Md1sIBvq2lR4Vx"}
		request = Net::HTTP::Get.new(url.to_s, headers)
		response = http.request(request)
		store_tweets(JSON.parse(response.body))
		resp = JSON.parse(response.body)
	end

	def search_tweet_data(keyword, user_id)
		url = URI("https://api.twitter.com/1.1/search/tweets.json?q=#{keyword}&result_type=recent&count=25")
		http = Net::HTTP.new(url.host, url.port);http.use_ssl = true
		headers = {'Authorization' => "Bearer AAAAAAAAAAAAAAAAAAAAADVZvgAAAAAAh6c%2F50%2BA5n5edeyjWyBZ%2F0m1Qd0%3DuNdHwnlEG6nJwjUvbeVEBHtwBt3Wqar8bXJ0Md1sIBvq2lR4Vx"}
		request = Net::HTTP::Get.new(url.to_s, headers)
		response = http.request(request)
		store_tweets(JSON.parse(response.body))
		resp = JSON.parse(response.body)
		tweet_ids = []
		resp["statuses"].each do |tweet|
			if ([user_id].include?(tweet["user"]["id"].to_s)) && tweet["in_reply_to_status_id"].nil? && tweet["in_reply_to_status_id_str"].nil? && tweet["in_reply_to_user_id"].nil? && tweet["in_reply_to_user_id_str"].nil? && tweet["in_reply_to_screen_name"].nil?
				tweet_ids << tweet["id"]
			end
		end
		tweet_ids.reverse
	end

	def get_gender(name)
		first_name = name.gsub(/mr|mrs|dr/i, '').strip.split(' ')[0]
		last_name = name.gsub(/mr|mrs|dr/i, '').strip.split(' ')[1]
		last_name = last_name.nil? ? name.gsub(/mr|mrs|dr/i, '').strip[0] : last_name
		encoded_url = URI.encode("http://api.namsor.com/onomastics/api/json/gendre/#{first_name}/#{last_name}")
		url = URI.parse(encoded_url); http = Net::HTTP.new(url.host, url.port)
		request = Net::HTTP::Get.new(url.to_s, headers={})
		response = http.request(request)
		resp = JSON.parse(response.body)
		resp
	end

	def store_tweets(resp)
		#Resque.enqueue(TweetData, resp["statuses"]) unless resp["statuses"].nil?
	end
end
