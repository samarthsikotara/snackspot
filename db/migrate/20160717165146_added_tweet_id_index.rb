class AddedTweetIdIndex < ActiveRecord::Migration
  def change
  	add_column :tweets, :user_id, :text
  	add_index :tweets, [:tweet_id, :user_id]
  end
end
