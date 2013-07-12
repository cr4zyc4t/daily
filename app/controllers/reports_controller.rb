class ReportsController < ApplicationController
	def index
		@user = current_user
		if (current_user == nil)
			redirect_to login_path , :notice => "Please Login your account"
		elsif current_user.level == 3
			@reports = Report.page(params[:page]).per(15)
		elsif current_user.level == 2
			@users = User.find_all_by_group_id(@user.group_id)
	    elsif current_user.level ==1 	    	
	    		@reports=  Report.find_all_by_user_id(current_user._id)
	    		#redirect_to session_path , :notice => "not permission"
	    elsif current_user.level == nil
	      redirect_to login_path , :notice => "Your account isn't actived"
	    end
	end

	def new
		@user = current_user
		if ((@user.level == 1 )|| (@user.level == 2))
			@report = @user.reports.new
			@catalog = Catalog.find(params[:id])
			@report.body = @catalog.body
			@report.catalog_id = @catalog.id
		else
			redirect_to reports_path, :notice => "You don't have permission to write a report!"
		end
	end
	def create
		@user = current_user
		
		@report = @user.reports.new(params[:report])
		if @report.save
			redirect_to reports_path
		else
			render :new
		end
	end

	def show
		if current_user != nil
			@report = Report.find(params[:id])
			@catalog = Catalog.find(@report.catalog_id)
		else redirect_to login_path, :notice => "You don't have permission to write a report!"
		end
	end

	def listreport
		@user = current_user
		@reports = Report.find_all_by_user_id(params[:id])
		@reportuser = User.find(params[:id])

	end
	
    
end