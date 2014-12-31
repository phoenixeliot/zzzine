class ViewController < ApplicationController
	def show
		@current = User.find_by(uid: params[:id])
	end

	def edit
		@current = User.find_by(uid: params[:id])
		@current.title, @current.style_id = params[:content], params[:style_id]
		@current.save
		redirect_to "/view/#{@current.uid}"
	end
end
