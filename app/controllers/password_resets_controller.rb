class PasswordResetsController < ApplicationController
	before_action :get_user , only: [:edit, :update]
	before_action :valid_user, only:[:edit, :update]
	def new
	end
	def create
		@user  = User.find_by_email(params['email'])
		if @user
			@user.create_reset_digest
			UserMailer.password_reset(@user).deliver
			flash[:info] = 'Password reset link instructions was sent to your email. Please check!!!'
			redirect_to root_url
		else 
			flash[:danger] = 'Email address not found !!!'
			render :new 
		end
	end
	def edit
	end
	def update
		if params[:user][:password].empty?
			@user.errors.add(:password, "can't be empty")
			render 'edit'
		elsif @user.update_attributes(user_params)
			session[:user_id] = @user.id
			session[:email] = @user.email 
			flash[:success] = "Password has been reset."
			redirect_to user_url(@user.id)
		else
			render 'edit'
		end
	end
  #define private function
  private
  def get_user
  	@user = User.find_by_email(params[:email]) 
  end
  def valid_user
  	unless (@user && @user.activated?)
  		redirect_to root_url
  	end
  end
  def user_params
  	params.require(:user).permit(:password, :password_confirmation)
  end
  # # def check_expiration
  # # 	if @user.password_reset_expired?
  # # 		flash[:danger] = "Password reset has expired."
  # # 		redirect_to new_password_reset_url
  # # 	end
  # end
end
