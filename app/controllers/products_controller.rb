class ProductsController < ApplicationController
  include ApplicationHelper

  before_action :page_scrape, only: [:create]

  def new
  end

  def create
    if return_website.blank?
      MetaWebsiteAdd.call(product_url: product_url, page: page_scrape)
    end
    if return_website.present?
      call_initial_scrape
      product_saved?
    else
      flash[:error] = "Website not supported at this time!"
      redirect_to new_product_path
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to "/users/#{current_user.id}"
  end

private

  def page_scrape
    user_agent = "Mozilla/6.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.0.7) Gecko/2009021910 Firefox/3.0.7"
    begin
      Nokogiri::XML(open(product_url,'User-Agent' => user_agent), nil,"UTF-8")
    rescue TypeError
      flash[:error] = "Page can't be found!"
      redirect_to new_product_path
    end
  end

  def return_website
    ProductWebsite.all.select do |saved_website|
      product_url.include?(saved_website.website_url)
    end.first
  end

  def call_initial_scrape
    InitialWebScrape.call(product_url: product_url, page: page_scrape, user: current_user)
  end

  def product_saved?
    if current_user.products.last.save
      flash[:success] = "'#{current_user.products.last.name}' has been saved"
      redirect_to "/users/#{current_user.id}"
    else
      flash[:error] = "Product could not be saved, try a different item!"
      redirect_to new_product_path
    end
  end

  def product_url
    params[:product].values.first
  end
end
