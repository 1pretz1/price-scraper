class ProductsController < ApplicationController
  include ApplicationHelper

  def new
    @product = Product.new
  end

  def create
    user_agent = "Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.0.7) Gecko/2009021910 Firefox/3.0.7"
    @page = Nokogiri::XML(open(product_url,'User-Agent' => user_agent), nil,"UTF-8")
    if return_website != nil
      call_initial_scrape
    else
      MetaWebsiteAdd.call(product_url: product_url, page: @page)
      call_initial_scrape
    end
    flash[:success] = "'#{current_user.products.last.name}' has been saved"
    redirect_to "/users/#{current_user.id}"
  end

 private

  def call_initial_scrape
    InitialWebScrape.call(product_url: product_url, page: @page, user: current_user)
  end

  def product_url
    params[:product].values.first
  end

  def return_website
    ProductWebsite.all.select do |saved_website|
      params[:product].values.first.include?(saved_website.website_url)
    end.first
  end
end
