class UsersController < ApplicationController
  def index
    if current_user == nil
      redirect_to login_path, :notice => "You aren't the user,please register "
    elsif current_user.level == 3
      @users = User.page(params[:page]).per(20)
    elsif current_user.level == 2
      @users = User.find_all_by_group_id(current_user.group_id)
    elsif current_user.level == 1
      @users = []
      @users[0] = current_user
    elsif current_user.level == nil
      redirect_to login_path, :notice => "Wating for confirmation"
    end
  end

  def show
    if current_user != nil && current_user.level == 3
      @user = User.find(params[:id])
    elsif current_user.level == 2 && (User.find(params[:id]).group_id == current_user.group_id )
      @user = User.find(params[:id])
    elsif current_user.level == 1
      @user = current_user
    else redirect_to login_path, :notice => "You don't have permission"
    end
  end

  def new
    @current_user = current_user
    if current_user == nil || current_user.level == 3
      @user = User.new
    else redirect_to reports_path, :notice => "You don't have permission to create a new user"
    end
  end

  def create
    @current_user = current_user
    @user =User.new(params[:user])
    if(current_user != nil && current_user.level == 3)
      if @user.save
        begin
          Email.registration_confirmation(@user).deliver
          redirect_to users_path, :notice => "Create successfull"
        end
      else render :new
      end
    elsif current_user != nil &&  (current_user.level==2 || current_user.level ==1 )
      redirect_to reports_path, :notice => "you don't have permission to create a new user"
    elsif (current_user == nil && @user.save )
      begin
        Email.registration_confirmation(@user).deliver
        @user =User.new(params[:user])
        redirect_to login_path, :notice => "Create successfull, waiting for confirmation"
      end
    else render '/users/new'
    end
  end

  def edit
    if current_user != nil && current_user.level == 3
      @user = User.find(params[:id])
    elsif current_user.level == 2 && (User.find(params[:id]).group_id == current_user.group_id )
      @user = User.find(params[:id])
    elsif current_user.level == 1
      @user = current_user
    else redirect_to login_path, :notice => "Login as the admin"
    end
  end

  def update
    if  current_user != nil && current_user.level == 3
      @user = User.find(params[:id])

      if @user.update_attributes(params[:user])
        redirect_to users_path, :notice => "Update successfull"
      else render :edit
      end
    # else
    # @user.update_attributes(params[:user])
    # redirect_to users_path, :notice => "Update successfull"
    # end
    elsif current_user.level ==2 || current_user.level ==1
      redirect_to reports_path, :notice => "you don't have permission to create a new user"
    end
  end

  def destroy
    if current_user != nil && current_user.level == 3
      User.find(params[:id]).destroy
      redirect_to users_path, :notice => "destroy successfull"
    else redirect_to login_path, :notice => "login as the admin"
    end
  end

end