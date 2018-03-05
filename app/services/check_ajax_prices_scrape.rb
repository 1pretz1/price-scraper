class CheckAjaxPricesScrape < CheckPricesScrape
attr_accessor :ajax_products, :driver

  def initialize(ajax_products:)
    @ajax_products = ajax_products
  end

  def self.call(*args)
    new(*args).call
  end

  def call
    fetch_pages(ajax_products)
  end

  def fetch_pages(ajax_products)
    ajax_products.each do |product|
      options = Selenium::WebDriver::Chrome::Options.new(args: ['headless'])
      @driver = Selenium::WebDriver.for(:chrome, options: options)
      @driver.get(product.product_url)
      fetch_price(product)
    end
    driver.quit
  end

  #WIP
  def fetch_price(product)
    begin
      sale_price = driver.find_element(xpath: product.product_website.sale_price_xpath).text
      price = driver.find_element(xpath: product.product_website.price_xpath).text
    rescue Selenium::WebDriver::Error::NoSuchElementError
      failed_fetch(product)
    end
    if sale_price.present?
      sale_price = correct_price_format(sale_price)
      compare_prices(sale_price: sale_price, product: product)
    end
  end
  #
end
