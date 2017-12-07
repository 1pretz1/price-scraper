class InitialWebScrape
  attr_accessor :product, :user_agent

  def initialize(product:)
    @product = product
    @user_agent = "Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.0.7) Gecko/2009021910 Firefox/3.0.7"
  end

  def self.call(*args)
    new(*args).call
  end

  def call
    Product.save_name_and_price(product: product, price: correct_price_format, name: product_header)
  end

  def product_url_check
    ProductWebsite.all.select do |saved_website|
      product.product_url.include?(saved_website.website_url)
    end
  end

  def web_page
    Nokogiri::HTML(open(product.product_url,'User-Agent' => user_agent), nil, "UTF-8")
  end

  def product_header
    web_page.css('h1').text
  end

  def price_text
    web_page.css(product_url_check[0].product_price_name).text
  end

  def correct_price_format
    price_text.gsub(/([^0-9.])/, "")
  end
end
