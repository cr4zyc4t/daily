class CatalogsController < ApplicationController
	def index
		@user = current_user
		if current_user == nil
			redirect_to login_path , :notice => "you aren't yet login"
		end
			@catalogs = Catalog.all
	end
	def new
	@user = current_user
		if @user.level == 3
		   @catalog= Catalog.new
		else
			redirect_to reports_path, :notice => "You don't have permission to create a new templace"
		end	
	end
	def create
		@user = current_user
		@catalog= Catalog.new(params[:catalog])
		if @catalog.save
			redirect_to catalogs_path
		else
			render :new
		end
	end

	def show
		@user = current_user
		if @user != nil
			@catalog = Catalog.find(params[:id])	
		else
			redirect_to login_path, :notice => "You don't have permission"
		end		
	end

	def edit
		@user = current_user
		if @user.level == 3
		   @catalog = Catalog.find(params[:id])
		else
			redirect_to reports_path, :notice => "You don't have permission to create a new templace"
		end	
		
	end

	def update
	  @user = current_user
		@catalog = Catalog.find(params[:id])
		if @catalog.update_attributes(params[:catalog])
			redirect_to catalogs_path
		else
			render :edit
		end
	end

	def destroy
		@user = current_user
		if @user.level == 3
			@catalog = Catalog.find(params[:id])
			@catalog.destroy
			redirect_to catalogs_path
		else
			redirect_to reports_path, :notice => "You don't have permission to create a new templace"
		end	

	end
end
