class GroupsController < ApplicationController
  # GET /groups
  # GET /groups.json
  def index
    @user = current_user
    if @user != nil && @user.level == 3
        @groups = Group.all
        respond_to do |format|
          format.html # index.html.erb
          format.json { render json: @groups }
        end
      else
        redirect_to users_path
    end
  end

  # GET /groups/1
  # GET /groups/1.json
  def show
    @user = current_user
    if (@user != nil) && (@user.level == 3 || @user.level == 2)
          @group = Group.find(params[:id])
          # @users = User.find_all_by_group_id(@group.id)
          # @users = @group.User.find(:all)

      respond_to do |format|
          format.html # show1.html.erb
          format.json { render json: @user }
      end
  
  else
    redirect_to login_path, :notice => "You don't have permission!"
  end
  end

  def show1
    @group = Group.find(params[:id])
    @users = User.find_all_by_group_id(@group.id)
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @group }
    end
  end

  # GET /groups/new
  # GET /groups/new.json
  def new
    @user = current_user
    if @user.level == 3
      @group = Group.new

      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @group }
      end
    end
    
  end

  # GET /groups/1/edit
  def edit
    @user = current_user
    if @user.level == 3
      @group = Group.find(params[:id])
    end
    
  end

  # POST /groups
  # POST /groups.json
  def create
    @group = Group.new(params[:group])

    respond_to do |format|
      if @group.save
        format.html { redirect_to @group, notice: 'Group was successfully created.' }
        format.json { render json: @group, status: :created, location: @group }
      else
        format.html { render action: "new" }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /groups/1
  # PUT /groups/1.json
  def update
    @group = Group.find(params[:id])

    respond_to do |format|
      if @group.update_attributes(params[:group])
        format.html { redirect_to @group, notice: 'Group was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    @user = current_user
    if @user.level == 3
      @group = Group.find(params[:id])
      @group.destroy

      respond_to do |format|
        format.html { redirect_to groups_url }
        format.json { head :no_content }
    end
    end
    
  end
end
