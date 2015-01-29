class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all.paginate(:page => params[:page], :per_page => 5)
   
  end
  # GET /users/1
  # GET /users/1.json
  def show
  end
  
  def login
    @user = User.new
  end

  def loginuser
    @user=User.where("user_email=? AND password=?",params[:user][:user_email],params[:user][:password]).last
    unless @user.nil?
      session[:user]=@user
      flash[:notice] = "Login successfully"
      redirect_to :action => "index"
    else
      flash[:notice]="Email password not matched"
      redirect_to :action => "login"
    end
   
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        @profile = Profile.create!(user_id:@user.user_id)
        format.html { redirect_to :login, notice: 'User was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.profile.destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  def logout
    session[:user] = nil
    flash[:notice] = "You are now logged out"
    redirect_to root_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:user_id, :user_name, :user_email, :password, :user_type, :password_confirmation)
    end
end