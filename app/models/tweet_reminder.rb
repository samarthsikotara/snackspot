class TweetReminder < ActiveRecord::Base

	set_rgeo_factory_for_column(:location_point, RGeo::Geographic.spherical_factory(:srid => 4326))

end