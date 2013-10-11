helpers do
	

	def get_current_user
		session[:user_id]
	end

	def current_user=(user_id)
		session[:user_id] = user_id
	end

	def logged_in?
		!current_user.nil?
	end
end