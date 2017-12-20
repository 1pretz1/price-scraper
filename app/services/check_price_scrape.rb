class CheckPriceScrape < InitialWebScrape
  class << self
    attr_accessor :user_agent, :price

    def initialize
      @user_agent = "Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.0.7) Gecko/2009021910 Firefox/3.0.7"
      @price = ""
    end

    def self.call(*args)
      new(*args).call
    end

    def call
      products_scrape
    end

    def products_scrape
      Product.all.each do |each_product|
        @page = Nokogiri::XML(open(each_product.product_url,'User-Agent' => user_agent), nil, "UTF-8")
        get_price
        compare_prices(each_product)
      end
    end

    def get_price
      page.remove_namespaces!
      if @page.xpath('//meta[contains(@property,"price")]') != nil
        price = @page.xpath('//meta[contains(@property,"price")]/@content').text
      else product.product_website.product_price_name != nil
        price = @page.css(product.product_website.now_price_name).text
      end
    end

    def compare_prices(product)
      if price != nil && price.to_f < product.price.to_f
        Product.save_sale_price(product: product, sale_price: price)
      end
    end
  end
end
