class AddedTweettext < ActiveRecord::Migration
  def change
  	add_column :tweets, :text, :text
  end
end
