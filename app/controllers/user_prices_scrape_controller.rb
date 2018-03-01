class UserPricesScrapeController < ApplicationController

  def create
    if none_ajax_products.present?
      CheckPricesScrape.call(none_ajax_products: none_ajax_products)
    end

    if ajax_products.present?
      CheckAjaxPricesScrape.call(ajax_products: ajax_products)
    end
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
