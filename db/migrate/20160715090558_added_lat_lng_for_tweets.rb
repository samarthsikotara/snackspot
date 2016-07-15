class AddedLatLngForTweets < ActiveRecord::Migration
  def change
  	add_column :tweets, :location_lat, :float, :default => 0.0
  	add_column :tweets, :location_lng, :float, :default => 0.0
  end
end
