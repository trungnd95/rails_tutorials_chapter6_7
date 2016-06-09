class UsersController < ApplicationController
  #index
  def index
  	@users = User.all 
  	render :index
  end
  #view show
  def show 
  	@user = User.find params[:id]
  end 
  #view create 
  def new
  	@user = User.new
  end
  #store data just created to database
  def create
  	@user = User.new user_params

    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render :new
    end
  end

  #strong method
  private
	def user_params
	  params.require(:user).permit :name, :email, :password,
	                               :password_confirmation
	end
end
