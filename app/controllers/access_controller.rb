class AccessController < ApplicationController
  def index
  	#display list of all users
  	
  end

  def login
  	#login form 
  end

  def attempt_login
  	# if params[:email].present? && params[:password].present? 
  	# 	@user  = User.where(params[:email]).first
  	# 	if @user
  			
  	# 	end
  	# end
  end

  def logout
  end
end
