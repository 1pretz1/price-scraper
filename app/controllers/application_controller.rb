require 'open-uri'

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :admin?, :url_host, :call_check_price_scrape

  def url_host(url)
    URI(url).host
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def authorize
    redirect_to '/login' unless current_user
  end

  def admin?
    current_user.admin == true
  end
end
