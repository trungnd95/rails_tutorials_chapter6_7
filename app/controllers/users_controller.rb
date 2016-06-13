class UsersController < ApplicationController
  before_action :check_logged_in , :except=> [:new,:create]
  before_action :correct_user , :only => [:edit, :update]
  before_action :check_admin , :only => [:destroy]
  #index
  def index
  	@users = User.where(:activated =>  true).paginate(page: params[:page], per_page: 5)
  	render :index
  end
  #view show
  def show 
  	@user_new = User.find params[:id]
  	@microposts = @user_new.microposts.paginate(page: params[:page] , per_page: 5)
  	@micropost = current_user.microposts.build 
  end 
  #view create 
  def new
  	@user = User.new
  end
  #store data just created to database
  def create
  	@user = User.new user_params
    if @user.save
    	UserMailer.account_activation(@user).deliver
      flash[:success] = "Please confirm your email address to continute!"
      redirect_to root_url
    else
    	flash[:danger] = "Ooopppss !!! Some thing went wrong !!"
      render :new
    end
  end

  #edit user 
  def edit
  	@user = User.find params[:id] 
  end

  #store data just edited to database
  def update 
  	@user = User.find(params[:id])
  	if @user.update_attributes(user_params)
  		flash[:success] = 'Updated !!!'
  		redirect_to @user 
  	else
  		flash[:danger] = 'Errors Information. Recheck!!	'
  		render :edit
  	end
  end
  #delete user 
  def destroy
  	user = User.find(params[:id])
  	user.destroy
  	flash[:success] = 'Deleted !!!'
  	redirect_to(:action => 'index')
  end

  #strong method
  private
	def user_params
	  params.require(:user).permit :name, :email, :password,
	                               :password_confirmation, :activation_digest,
	                               :activated,:activated_at
	end
	
	def correct_user
      @user = User.find(params[:id])
      redirect_to(:back) unless current_user?(@user)
  end

  def check_admin
  	redirect_to(root_url) unless current_user.admin?
  end

  def send_email_activation
  	UserMailer.account_activation(self).deliver_now
  end
end
