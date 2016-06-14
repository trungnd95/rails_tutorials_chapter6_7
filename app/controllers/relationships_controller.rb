class RelationshipsController < ApplicationController
	before_action :check_logged_in
	#follow
	def create
		@user_new = User.find(params[:followed_id])
	    current_user.follow(@user_new)
	    respond_to do |format|
	    	format.html { redirect_to @user_new }
	    	format.js
	    end
	end
	#unfollow
	def destroy
		@user_new = Relationship.find(params[:id]).followed
    	current_user.unfollow(@user_new)
    	respond_to do |format|
    		format.html { redirect_to @user_new }
    		format.js
    	end
	end
end
