require 'rufus/scheduler'
include WelcomeHelper

## to start scheduler
scheduler = Rufus::Scheduler.new
client = SendGrid::Client.new(api_key: TaskbobConfig.SENDGRID_APIKEY)

## It will print message every i minute
scheduler.every("1m") do
  puts("HELLO #{Time.current}")
  #res = client.send(SendGrid::Mail.new(to: 'samarthsikotara@gmail.com', from: 'samarth@taskbob.com', from_name: "Sammy",  subject: 'Hello world!', text: 'Hi there!', html: '<b>Hi there!</b>'))
  # ::Locality.all.each do |locality|
  # 	tweet_data(locality.latitude, locality.longitude)
  # 	p "Fetched tweets fot #{locality.name}"
  # end
  tweet_ids = search_tweet_data("taskbob", "2897608646")
  tweet_ids.each do |tweet_id|
    user_tweet = UserTweet.find_by_tweet_id(tweet_id) rescue nil
    if user_tweet
      p "Already Retweeted Tweet #{tweet_id}"
    else
      ::User.all.each do |user|
        user.tweet("", tweet_id)
        ::UserTweet.create(:user_id => user.id, :tweet_id => tweet_id)
      end
      res = client.send(SendGrid::Mail.new(to: 'samarth@taskbob.com', from: 'samarthsikotara@gmail.com', from_name: "TweetMe",  subject: 'New Retweets', text: 'Hi there!', html: "<b>New Retweet! for Tweet #{tweet_id}</b>"))
    end
  end
end

## Prints the message every day at noon
scheduler.cron("0,2 * * * *") do
  puts("HI #{Time.current}")
end

scheduler.in '20m' do
  puts "order butter"
end

scheduler.at 'Thu Mar 26 07:31:43 +0900 2009' do
  puts 'order pizza'
end

scheduler.cron '0 22 * * 1-5' do
  # every day of the week at 22:00 (10pm)
  puts 'activate security system'
end

scheduler.every '5m' do
  puts 'check status report'
end