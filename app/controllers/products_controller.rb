class ProductsController < ApplicationController

  include ApplicationHelper

def new
    @product = Product.new
  end

  def create
    @product = current_user.products.create(product_params)
    if @product.save
      InitialWebScrape.call(product: @product)
      redirect_to "/users/#{current_user.id}"
      flash[:success] = "#{@product.name} has been saved"
    else
      render 'new'
    end
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
