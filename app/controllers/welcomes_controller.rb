class WelcomesController < ApplicationController

  include WelcomeHelper

	def real_time
    if request.method == "GET"
      if params['hub.mode'] =='subscribe' && params['hub.verify_token'] =='cool'
        render :text => params['hub.challenge']
      else
        render :text => 'Failed to authorize facebook challenge request'
      end
    elsif request.method == "POST"
      #do stuff with information
      request.raw_post 
    end
  end

  def index
    latitude = params[:latitude];longitude = params[:longitude]
    geo_data = tweet_data(latitude, longitude)
    @points = geo_data["statuses"].map { |data| [data["user"]["name"], data["user"]["description"], data["geo"]["coordinates"][0], data["geo"]["coordinates"][1], data["user"]["profile_image_url"], data["user"]["screen_name"], data["text"]] unless data["geo"].nil? }.compact
  end

end
