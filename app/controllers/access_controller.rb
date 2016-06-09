class AccessController < ApplicationController
  #callback
  before_action :check_logged_in, :except => [:login, :attempt_login, :logout]
  def index
  	#display list of all users
  	@users =  User.all
  	render 'users/index'
  end

  def login
  	#login form 
  end

  def attempt_login
  	if params[:email].present? && params[:password].present? 
  		user  = User.where(:email => params[:email]).first
  		if user
  			authorize_user  = user.authenticate(params[:password])
  		end
  	end
  	if authorize_user 
  		session[:user_id] =  authorize_user.id
  		session[:email] = authorize_user.email 
  		flash[:success] =  'You are logged in !'
 		redirect_to(:action => 'index') 
  	else
  		session[:user_id] =  nil
  		session[:email] = nil
  		flash[:danger]	= 'Invalid email/password combination !!'
  		redirect_to(:action =>'login')
  	end
  end

  def logout
  	flash[:success]	= 'Logout success !!'
  	redirect_to(:action =>'login')
  end
end
