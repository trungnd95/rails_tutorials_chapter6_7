class AccountActivationsController < ApplicationController
	def edit 
		user  = User.find_by_activation_digest(params[:id])
		if user 
			user.update_attribute(:activated,  true)
			user.update_attribute(:activation_digest,nil)
			user.update_attribute(:activated_at,Time.zone.now)
			flash[:success] =  "Welcome to Sample app . Your account have been actived.
								Please sign in to continute!!! "
			redirect_to login_url
		else 
			flash[:danger] = "Err!! User doesn't exist"
			redirect_to root_url
		end
	end

end
