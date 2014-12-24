class ViewController < ApplicationController
	def show

		@current = User.find_by(uid: params[:id])
	
	end
end
