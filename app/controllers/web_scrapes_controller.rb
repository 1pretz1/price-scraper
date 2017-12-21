class WebScrapesController < ApplicationController

  def create
    CheckPriceScrape.call(current_user: current_user)
    redirect_to "/users/#{current_user.id}"
  end
end
