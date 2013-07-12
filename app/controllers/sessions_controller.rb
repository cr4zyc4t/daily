class SessionsController < ApplicationController
	def create 
		if user = User.authenticate(params[:email], params[:password]) 
			session[:user_id] = user.id 
			if user.level != nil && user.level != 0
				 redirect_to reports_path, :notice => "Logged in successfully" 
			else
				reset_session 
				redirect_to login_path, :notice => "wating for confirmation" 
			end
		else 
			flash.now[:alert] = "Invalid login/password combination" 
			render :action => 'new' 
		end 
	end

	def destroy 
		reset_session 
		redirect_to login_path, :notice => "You successfully logged out" 
	end 
	
end