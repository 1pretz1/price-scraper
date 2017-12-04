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

    page = Nokogiri::XML(open(@product.product_url,'User-Agent' => user_agent), nil, "UTF-8")
    @header = page.css('h1').text
    product_url_check = ProductWebsite.all.select { |x| @product.product_url.include?(x.website_url) }
    price_tag_text = page.css(product_url_check[0].product_price_name).text
    @correct_price_format = price_tag_text.gsub(/([^0-9.])/, "")
    @product = @product.update_attributes(name: @header, price: @correct_price_format)
  end

  private

  def product_params
    params.require(:product).permit(:product_url)
  end
end
    #^search through HTML for 'h1' (usually the name of product)
    #page.xpath("//span")
    #^search through span tags
    #generic_info = page.xpath("//span[contains(@class, 'price')]").text
    #^search through span tags thats have a class that includes 'price'
    #page.xpath("//span").text.partition('£').last.split(' ').first
    #^search through span tags until '£' then return first one
    #^search html class/id for '.now_price'
    #page.xpath("//span").text.split(' ').select { |x| x.include?('£') }
    #parse_page = Nokogiri::HTML(page)
    #page = open(@product.product_url)
#URI(url).host

#h = ProductWebsite.all.select { |x| @product.product_url.include?(x.website_url) }
#^iterate through ProductWebsites and see if product_url includes a saved website url
  #if it does then return the ProductWebsite object
  #a = page.css(h[0].product_price_name).text
  #^finds price of regular item
  #page.css(h[0].now_price_name).text
  #^finds price of sale item
  #stringint = a.gsub(/([^0-9.])/, "")
  #^saves everything thats isnt a number or . to a new variable
