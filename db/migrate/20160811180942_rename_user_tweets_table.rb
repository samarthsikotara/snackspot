class RenameUserTweetsTable < ActiveRecord::Migration
  def change
  	rename_table :user_tweet, :user_tweets
  end
end
