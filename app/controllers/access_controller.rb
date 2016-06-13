class AccessController < ApplicationController
  #callback
  before_action :check_logged_in, :except => [:login, :attempt_login, :logout]
  def index
  	#display list of all users
  	@users =  User.paginate(page: params[:page], per_page: 5)
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
  		if user.activated 
	  		session[:user_id] =  authorize_user.id
	  		session[:email] = authorize_user.email 
	  		flash[:success] =  'You are logged in !'
	  		redirect_to(:action => 'index') 
	  	else
	  		flash[:danger] =  'Please active your account by following instructions 
	  		in the account confirmation email you received to preceed !!!'
	  		redirect_to :login
	  	end
  	else
  		
  		flash[:danger]	= 'Invalid email/password combination !!'
  		redirect_to(:action =>'login')
  	end
  end

  def logout
  	session[:user_id] =  nil
  	session[:email] = nil
  	flash[:success]	= 'Logout success !!'
  	redirect_to(:action =>'login')
  end
end
