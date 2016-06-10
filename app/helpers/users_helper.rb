module UsersHelper
	def current_user 
		if (session[:user_id])
			user_id = session[:user_id]
			@user = User.find(user_id)
			$current_user ||= @user
		end
	end
	def current_user?(user)
		user == current_user
	end
end
