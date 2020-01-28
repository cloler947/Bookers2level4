class RelationshipsController < ApplicationController
	

	def create
		@user = User.find(params[:followed_id])
		@followings = current_user.follow(@user)
		redirect_back(fallback_location: @user)
	end

	def destroy
		@user = User.find(params[:followed_id])
		@followings = current_user.unfollow(@user)
		redirect_back(fallback_location: @user)
	end
end
