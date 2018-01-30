class MetaWebsiteAdd
  include ApplicationHelper
  attr_accessor :page, :product_url, :new_website

  def initialize(product_url:, page:)
    @product_url = product_url
    @page = page
    @new_website = {}
  end

  def self.call(*args)
    new(*args).call
  end

  def call
    has_info?
  end

  def has_info?
    if page.xpath('//meta[contains(@property,"price:amount")]/@content').text.present? &&
      page.xpath('//meta[contains(@property,"title")]/@content').text.present? &&
      page.xpath('//meta[contains(@property,"image")]/@content').text.present?
      get_website_info
    end
  end

  def get_website_info
    new_website[:website_url] = url_host(product_url)
    new_website[:price_xpath] = '//meta[contains(@property,"price:amount")]/@content'
    new_website[:sale_price_xpath] = '//meta[contains(@property,"price:amount")]/@content'
    new_website[:image_xpath] = '//meta[contains(@property,"image")]/@content'
    new_website[:title_xpath] = '//meta[contains(@property,"title")]/@content'
    save_website
  end

  def save_website
    ProductWebsite.create(
      website_url: new_website[:website_url],
      price_xpath: new_website[:price_xpath],
      sale_price_xpath: new_website[:sale_price_xpath],
      image_xpath: new_website[:image_xpath],
      title_xpath: new_website[:title_xpath]
    )
  end
end
