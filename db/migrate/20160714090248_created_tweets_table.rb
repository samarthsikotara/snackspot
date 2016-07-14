class CreatedTweetsTable < ActiveRecord::Migration
  def change
  	create_table :tweets do |t|
  		t.string 		:tweet_id
  		t.datetime 	:tweet_created_at
  		t.string 		:name
  		t.text			:profile_pic_url
  		t.string		:screen_name
  		t.text			:location
  		t.point  		:location_point
  		t.string		:tweets_count
  		t.string		:followers_count
  		t.string		:following_count

  		t.timestamps
  	end
  end
end
