class WebScrapesController < ApplicationController

  def create
    CheckPricesScrape.call( {user: current_user} )
    redirect_to "/users/#{current_user.id}"
  end
end
