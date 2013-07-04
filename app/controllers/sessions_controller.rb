class SessionsController < ApplicationController
	def new
	end
	def create
		user = User.find_by_email(params[:session][:email].downcase)
		if user && user.authenticate(params[:session][:password])
			log_in user
			redirect_back_or user
			#Login and redirect to user's profile page
		else
			flash.now[:error] = 'Invalid email/password combination'
			render 'new'
			#Create an error msg and re-render the signin form
		end
	end
	def destroy
		log_out
		redirect_to root_url
	end
end
