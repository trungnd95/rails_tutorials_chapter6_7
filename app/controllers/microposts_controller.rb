class MicropostsController < ApplicationController
	before_action :check_logged_in, only: [:create, :destroy]
	before_action :correct_user,   only: :destroy
	def create
		@micropost = current_user.microposts.build(micropost_params)

		if @micropost.save 
			flash[:success] =  "Micropost created !!"
			redirect_to root_url
		else 
			# flash[:danger] = 'Some thing went wrong !!'
			redirect_to :back
		end
	end
	def destroy
		@micropost.destroy
		flash[:success] =  'Deleted This Post'
		redirect_to :back
	end
	private 
	def micropost_params 
		params.require(:micropost).permit(:title, :content)
	end
	def correct_user 
		@micropost = current_user.microposts.find_by(id: params[:id])
		if @micropost.nil?
			flash[:danger] =  'Permision denied !!'
      		redirect_to :back 
      	end
	end
end
