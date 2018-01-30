class CheckPriceScrape < InitialWebScrape
  include ApplicationHelper
  attr_accessor :user_agent, :user

  def initialize(user:)
    @user_agent = "Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.0.7) Gecko/2009021910 Firefox/3.0.7"
    @user = user
  end

  def self.call(*args)
    new(*args).call
  end

  def call
    products_scrape
  end

  def products_scrape
    user.products.all.each do |product|
      page = Nokogiri::HTML(open(product.product_url,'User-Agent' => user_agent), nil, "UTF-8")
      get_price(product: product, page: page)
    end
  end

  def get_price(product:, page:)
    page.remove_namespaces!
    sale_price = page.xpath(product.product_website.sale_price_xpath).text
    if sale_price.present?
      compare_prices(sale_price: sale_price, product: product)
    end
  end

  def compare_prices(sale_price:, product:)
    if correct_price_format(sale_price).to_f < product.price.to_f
      product.update_attributes(sale_price: sale_price)
    end
  end
end
