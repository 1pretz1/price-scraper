require 'selenium-webdriver'

class AjaxScrape < InitialWebScrape
  attr_accessor :driver, :website, :user, :attributes, :url

  def initialize(url:, user:, website:)
    options = Selenium::WebDriver::Chrome::Options.new(args: ['headless'])
    @driver = Selenium::WebDriver.for(:chrome, options: options)
    @url = url
    @driver.get(url)
    @website = website
    @user = user
    @attributes = {}
  end

  def self.call(*args)
    new(*args).call
  end

  def call
    get_info
    save_info
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
    user.products.create(
      product_url: url,
      price: attributes[:price],
      name: attributes[:title],
      image_url: attributes[:image],
      product_website_id: website.id
    )
  end
end
