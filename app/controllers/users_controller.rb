class UsersController < ApplicationController
  include UserShowHelper

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to '/'
    else
      flash[:error] = @user.errors.full_messages
      redirect_to new_user_path
    end
  end

  def show
    current_user
    if params[:items] == "SALE"
      @items = DisplayProductFiltersQuery.new(user: current_user).on_sale_list
    else params[:items] == "ALL"
      @items = DisplayProductFiltersQuery.new(user: current_user).active_list
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
