class InitialWebScrape
  attr_accessor :product, :user_agent, :attributes

  def initialize(product:)
    @product = product
    @user_agent = "Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.0.7) Gecko/2009021910 Firefox/3.0.7"
    @attributes = {}
  end

  def self.call(*args)
    new(*args).call
  end

  def call
    get_info
    Product.save_product_attributes(
                                product: product,
                                price: correct_price_format,
                                name: attributes[:title],
                                description: attributes[:description],
                                image_url: attributes[:image],
                               )
  end

  def product_url_check
    ProductWebsite.all.select do |saved_website|
      product.product_url.include?(saved_website.website_url)
    end
  end

  def web_page
    Nokogiri::XML(open(product.product_url,'User-Agent' => user_agent), nil, "UTF-8")
  end

  def product_header
    web_page.css('h1')[0].text
  end

  def price_text
    if attributes[:price] == nil
      web_page.css(product_url_check[0].product_price_name)[0].text
    else
      attributes[:price]
    end
  end

  def correct_price_format
    price_text.gsub(/([^0-9.])/, "")
  end

  def get_info
    binding.pry
    attributes[:title] = web_page.at('meta[property="og:title"]')['content']
    attributes[:description] = web_page.at('meta[property="og:description"]')['content']
    attributes[:image] = web_page.at('meta[property="og:image"]')['content']
    if web_page.at('meta[property="og:price:amount"]') != nil
      attributes[:price] = web_page.at('meta[property="og:price:amount"]')['content']
    end
  end
end
