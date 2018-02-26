class CheckPricesScrape < InitialScrape
  include ApplicationHelper
  attr_accessor :user_agent, :check_price_params

  def initialize(check_price_params = {})
    @check_price_params = check_price_params
    @user_agent = "Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.0.7) Gecko/2009021910 Firefox/3.0.7"
  end

  def self.call(*args)
    new(*args).call
  end

  def call
    #debate
    if user == false
      fetch_pages(check_price_params.fetch_values(:none_ajax_list, :method))
    else
      fetch_pages(user.products)
    end
  end

  def fetch_pages(fetch_params = {})
    fetch_param.all.each do |product|
      page = Nokogiri::HTML(open(product.product_url,'User-Agent' => user_agent), nil, "UTF-8")
      get_price(product: product, page: page)
    end
  end

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
    end
  end
end
