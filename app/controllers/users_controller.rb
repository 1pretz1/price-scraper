class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to '/'
    else
      render 'new'
    end
  end

  def show
    current_user
    @orders = current_user.products.group_by { |x| url_host(x.product_url) }
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

end
