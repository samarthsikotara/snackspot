class AddedUserTweetsTable < ActiveRecord::Migration
  def change

  	create_table :user_tweet do |t|
  		t.integer :user_id
  		t.integer :tweet_id

  		t.timestamps
  	end

  end
end
