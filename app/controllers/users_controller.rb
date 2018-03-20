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
    @active_items = active_items
    @sale_items = sale_items

    if params[:items] == 'SALE'
      @items = group_by_brand(@sale_items)
    else
      @items = group_by_brand(@active_items)
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
