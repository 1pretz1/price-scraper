require 'open-uri'

class InitialWebScrape
  attr_accessor :page, :product, :user_agent, :attributes, :new_website

  def initialize(product:)
    @product = product
    @user_agent = "Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.0.7) Gecko/2009021910 Firefox/3.0.7"
    @page = Nokogiri::XML(open(product.product_url,'User-Agent' => user_agent), nil, "UTF-8")
    @attributes = {}
    @new_website = {}
  end

  def self.call(*args)
    new(*args).call
  end

  def call
    if product.product_website == nil
      has_everything?
    end
    get info

    Product.save_product_attributes(
                                product: product,
                                price: attributes[:price],
                                name: attributes[:title],
                                image_url: attributes[:image],
                                product_website_id: attributes[:product_website_id]
    )
  end

  def correct_price_format(price)
    price = price.gsub(/([^0-9.])/, "")
  end

  def get_info
    page.remove_namespaces!
    #add title and image column to ProductWebsite then alter 2 lines below
    attributes[:title] = page.xpath('meta[property="og:title"]')['content']
    attributes[:image] = page.xpath('meta[property="og:image"]')['content']
    attributes[:price] = page.xpath(product.product_website.product_price_name).text
    attributes[:product_website_id] = product.product_website.id
    correct_price_format(attributes[:price])
  end



#METAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA

  def has_everything?
    page.remove_namespaces!
    attributes[:price] = page.xpath('//meta[contains(@property,"price:amount")]/@content').text
    attributes[:title] = page.xpath('//meta[contains(@property,"title")]/@content').text
    attributes[:image] = page.xpath('//meta[contains(@property,"image")]/@content').text
    if attributes[:price] != nil &&
      attributes[:title] != nil &&
      attributes[:image] != nil
      get_website_info
    end
  end

  def save_website
    ProductWebsite.add_website(
      website_url: new_webiste[:website_url],
      product_price_name: new_website[:product_price_name],
      now_price_name: new_website[:now_price_name]
    )
  end

  def get_website_info
    new_website[:website_url] = url_host(product.product_website)
    new_website[:product_price_name] = '//meta[contains(@property,"price:amount")]/@content'
    new_website[:now_price_name] = '//meta[contains(@property,"price:amount")]/@content'
    #add image and title here website
    save_website
  end

  def url_host(url)
    URI(url).host
  end

  def product_website
    ProductWebsite.all.select do |saved_website|
      params[:product].values.first.include?(saved_website.website_url)
    end.first
  end
end
