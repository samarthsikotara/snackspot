class CreatedTweetReminders < ActiveRecord::Migration
  def change

  	create_table :tweet_reminders do |t|
  		t.text 		:name
  		t.text 		:email_id
  		t.point 	:location_point
  		t.boolean :enable

  		t.timestamps
  	end

  end
end
