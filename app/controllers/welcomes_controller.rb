class WelcomesController < ApplicationController

	def real_time
    if request.method == "GET"
      if params['hub.mode'] =='subscribe' && params['hub.verify_token'] =='cool'
        render :text => params['hub.challenge']
      else
        render :text => 'Failed to authorize facebook challenge request'
      end
    elsif request.method == "POST"
      #do stuff with information 
    end
  end

end
