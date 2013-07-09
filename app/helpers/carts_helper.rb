module CartsHelper
	def store_location
		session[:return_to] = request.url
	end
	def loged_in?
		@current_user ||= User.find_by_remember_token(cookies[:remember_token])
		!@current_user.nil?
	end
end
