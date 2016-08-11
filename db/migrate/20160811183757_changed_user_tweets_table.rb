class ChangedUserTweetsTable < ActiveRecord::Migration
  def change
  	change_column :user_tweets, :tweet_id, :text
  end
end
