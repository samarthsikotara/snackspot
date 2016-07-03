module WelcomeHelper

	def tweet_data(lat, lon)
		url = URI("https://api.twitter.com/1.1/search/tweets.json?q=&geocode=#{lat},#{lon},5km&result_type=recent&count=1000000000")
		http = Net::HTTP.new(url.host, url.port);http.use_ssl = true
		headers = {'Authorization' => "Bearer AAAAAAAAAAAAAAAAAAAAADVZvgAAAAAAh6c%2F50%2BA5n5edeyjWyBZ%2F0m1Qd0%3DuNdHwnlEG6nJwjUvbeVEBHtwBt3Wqar8bXJ0Md1sIBvq2lR4Vx"}
		request = Net::HTTP::Get.new(url.to_s, headers)
		response = http.request(request)
		resp = JSON.parse(response.body)
	end
end
