class CheckPricesWorker
  include Sidekiq::Worker

  def perform
    if none_ajax_products.present?
      CheckPricesScrape.call(none_ajax_products: none_ajax_products)
    end

    if ajax_products.present?
      CheckAjaxPricesScrape.call(ajax_products: ajax_products)
    end
  end

  def none_ajax_products
    ListProductsQuery.new(user: false).all_none_ajax
  end

  def ajax_products
    ListProductsQuery.new(user: false).all_ajax
  end
end
