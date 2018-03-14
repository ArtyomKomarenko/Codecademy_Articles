class UsersController < ApplicationController

  skip_before_action :require_user, only: [:new, :create]
  before_action :restrict_user, only: :new
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to '/'
    else
      redirect_to '/signup'
    end
  end

  def show
    @user = User.find(params[:id]) if params[:id]
  end

  def edit
    @user = User.find(params[:id]) if params[:id]
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to profile_path
    else
      render profile_edit_path
    end
  end
  
  private
  
  	def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password)
    end
end
