require 'open-uri'

class ProductsController < ApplicationController

  def new
    @product = Product.new
  end

  def create
    @product = current_user.products.create(product_params)
    if @product.save
      web_scraper
      redirect_to '/'
    else
      render 'new'
    end
  end

  def web_scraper
    user_agent = "Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.0.7) Gecko/2009021910 Firefox/3.0.7"

    page = Nokogiri::HTML(open(@product.product_url,'User-Agent' => user_agent), nil, "UTF-8")
    @header = page.css('h1').text
    page.xpath("//span")
    @topman_price = page.xpath("//span[contains(@class, 'price')]")[2].text
    #page.xpath("//span").text.split(' ').select { |x| x.include?('£') }
    #parse_page = Nokogiri::HTML(page)
    #page = open(@product.product_url)
    binding.pry
  end

  private

  def product_params
    params.require(:product).permit(:product_url)
  end


end
