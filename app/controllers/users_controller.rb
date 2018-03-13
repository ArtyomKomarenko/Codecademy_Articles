class UsersController < ApplicationController

  skip_before_action :require_user
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
  
  private
  
  	def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password)
    end
end
