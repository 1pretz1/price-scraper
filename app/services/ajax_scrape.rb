require 'selenium-webdriver'

class AjaxScrape
  attr_accessor :driver

  def initialize(url:, website:)
    options = Selenium::WebDriver::Chrome::Options.new(args: ['headless'])
    driver = Selenium::WebDriver.for(:chrome, options: options)
    driver.get(url)
  end

  def self.call(*args)
    new(*args).call
  end

  def call
    get_info
  end

  def get_info
    price = driver.find_element(xpath: website.price_xpath).text
    image = driver.find_element(xpath: website.image_xpath).text
    title = driver.find_element(xpath: website.title_xpath).text
    driver.quit
  end
end
