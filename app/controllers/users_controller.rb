class UsersController < ApplicationController
	def destroy
		user = User.find_by(uid: params[:id])
		user.tweets.each do |tweet|
			tweet.gif.delete
			tweet.delete
		end
		
		user.delete

		redirect_to root_path
	end
end
