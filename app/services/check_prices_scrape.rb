class CheckPricesScrape < InitialScrape
  include ApplicationHelper
  attr_accessor :user_agent, :none_ajax_products

  def initialize(none_ajax_products:)
    @none_ajax_products = none_ajax_products
    @user_agent = "Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.0.7) Gecko/2009021910 Firefox/3.0.7"
  end

  def self.call(*args)
    new(*args).call
  end

  def call
    fetch_prices(none_ajax_products)
  end

  def fetch_prices(none_ajax_products)
    none_ajax_products.each do |product|
      begin
        page = Nokogiri::HTML(open(product.product_url,'User-Agent' => user_agent), nil, "UTF-8")
        get_price(product: product, page: page)
      rescue OpenURI::HTTPError
        failed_fetch(product)
      end
    end
  end

  def failed_fetch(product)
    product.increment!(:failed_attempts, 1)
    return product.destroy if product.failed_attempts == 4
  end

#WIP
  def check_page
    if page.xpath(product.product_website.sale_price_xpath).present? ||
       page.xpath(product.product_website.price_xpath).present?
       get_price
    end
  end
#

  def get_price(product:, page:)
    page.remove_namespaces!
    sale_price = page.xpath(product.product_website.sale_price_xpath).text
    if sale_price.present?
      sale_price = correct_price_format(sale_price)
      compare_prices(sale_price: sale_price, product: product)
    end
  end

  def compare_prices(sale_price:, product:)
    if product.price.to_f > sale_price.to_f ||
      product.sale_price.to_f > sale_price.to_f
      product.update_attributes(sale_price: sale_price)
    elsif product.sale_price.to_f < sale_price.to_f &&
      product.price.to_f > sale_price.to_f
      product.update_attributes(sale_price: sale_price)
    elsif product.price.to_f == sale_price.to_f
      product.update_attributes(sale_price: nil)
    end
  end
end
