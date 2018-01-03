class InitialWebScrape
  attr_accessor :page, :product, :user_agent, :attributes

  def initialize(product:)
    @product = product
    @user_agent = "Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.0.7) Gecko/2009021910 Firefox/3.0.7"
    @page = Nokogiri::XML(open(product.product_url,'User-Agent' => user_agent), nil, "UTF-8")
    @attributes = {}
  end

  def self.call(*args)
    new(*args).call
  end

  def call
    get_info
    Product.save_product_attributes(
                                product: product,
                                price: attributes[:price],
                                name: attributes[:title],
                                description: attributes[:description],
                                image_url: attributes[:image],
                               )
  end

  def correct_price_format(price)
    price = price.gsub(/([^0-9.])/, "")
  end

  def get_info
    attributes[:title] = page.at('meta[property="og:title"]')['content']
    attributes[:description] = page.at('meta[property="og:description"]')['content']
    attributes[:image] = page.at('meta[property="og:image"]')['content']
    get_price
  end

  def get_price
    page.remove_namespaces!
    if page.xpath('//meta[contains(@property,"price:amount")]') != nil
      attributes[:price] = page.xpath('//meta[contains(@property,"price:amount")]/@content').text
    else product.product_website.product_price_name != nil
      attributes[:price] = page.xpath(product.product_website.product_price_name).text
    end
    correct_price_format(attributes[:price])
  end
end
