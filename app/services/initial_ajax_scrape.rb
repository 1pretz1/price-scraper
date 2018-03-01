require 'selenium-webdriver'

class InitialAjaxScrape < InitialScrape
  attr_accessor :driver, :website, :user, :attributes, :url

  def initialize(url:, user:, website:)
    @url = url
    @user = user
    @website = website
    @attributes = {}
    get_page(url)
  end

  def self.call(*args)
    new(*args).call
  end

  def call
    get_info
    save_info
  end

  def get_page(url)
    options = Selenium::WebDriver::Chrome::Options.new(args: ['headless'])
    @driver = Selenium::WebDriver.for(:chrome, options: options)
    @driver.get(url)
  end

  def get_info
    price = driver.find_element(xpath: website.price_xpath).text
    attributes[:price] = correct_price_format(price)
    #META tags - attribute('content')
    attributes[:image] = driver.find_element(xpath: website.image_xpath)
                         .attribute('content')
    attributes[:title] = driver.find_element(xpath: website.title_xpath)
                         .attribute('content')
    driver.quit
  end

  def save_info
    product = Product.create(
      product_url: url,
      price: attributes[:price],
      name: attributes[:title],
      image_url: attributes[:image],
      product_website_id: website.id
    )
    user.product_users.create(user_id: user.id, product_id: product.id)
  end
end
