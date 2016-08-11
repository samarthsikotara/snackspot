class SessionsController < ApplicationController
  def create
  	auth = env["omniauth.auth"]
  	user = ::User.find_by_uid(auth.uid) rescue nil
  	if user.present?
  		session[:user_id] = user.id
    	redirect_to root_path
  	else
  		user = ::User.new(:provider => auth.provider, :uid => auth.uid, :name => auth.info.name, :oauth_token => auth.credentials.token, :oauth_secret => auth.credentials.secret)
  		user.save!
  		session[:user_id] = user.id
    	redirect_to root_path
  	end
  end
 
  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
