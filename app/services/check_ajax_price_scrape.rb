class AjaxCheckPriceScrape < InitialAjaxScrape
attr_accessor :ajax_list, :driver

  def initialize(ajax_list:)
    @ajax_list = ajax_list
  end

  def self.call(*args)
    call.new(args)
  end

  def call
    fetch_pages
  end

  def fetch_pages
    ajax_list.each do |product|
      page = get_page(product.product_url)
      get_price(product: product, page: page)
    end
  end

  def get_price(product:, page:)
    sale_price = driver.find_element(xpath: website.sale_price_xpath).text
    if sale_price.present?
      sale_price = correct_price_format(get_price)
      compare_prices(sale_price: sale_price, product: product)
    end
  end
end
