class CheckPriceScrape < InitialWebScrape
  attr_accessor :user_agent, :price, :current_user

  def initialize(current_user:)
    @user_agent = "Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.0.7) Gecko/2009021910 Firefox/3.0.7"
    @price = price
    @current_user = current_user
  end

  def self.call(*args)
    new(*args).call
  end

  def call
    products_scrape
  end

  def products_scrape
    current_user.products.all.each do |product|
      @page = Nokogiri::XML(open(product.product_url,'User-Agent' => user_agent), nil, "UTF-8")
      compare_prices(price: get_price, product: product)
    end
  end

  def get_price
    page.remove_namespaces!
    if page.xpath('//meta[contains(@property,"price:amount")]') != nil
      price = page.xpath('//meta[contains(@property,"price:amount")]/@content').text
    else product.product_website.product_price_name != nil
      price = page.xpath(product.product_website.now_price_name).text
    end
  end

  def compare_prices(price:, product:)
    if price != nil && price != "" && price.to_f < product.price.to_f
      correct_price_format(price)
      Product.save_sale_price(product: product, sale_price: price)
    end
  end
end
