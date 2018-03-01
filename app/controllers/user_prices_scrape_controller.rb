class UserPricesScrapeController < ApplicationController

  def create
    CheckPricesScrape.call(none_ajax_products: none_ajax_products)
    CheckAjaxPricesScrape.call(ajax_products: ajax_products)
    redirect_to "/users/#{current_user.id}"
  end

  private

  def none_ajax_products
    ListProductsQuery.new(user: current_user).none_ajax
  end

  def ajax_products
    ListProductsQuery.new(user: current_user).ajax
  end
end
