class ProductWebsitesController < ApplicationController

  def new
    @product_website = ProductWebsite.new
  end

  def create
    @product_website = ProductWebsite.create(product_website_params)
    if @product_website.save
      flash[:success] = "'#{@product_website.website_url}' has been saved"
      redirect_to '/product_websites/new'
    else
      flash[:error] = "'#{@product_website.website_url}' can't be saved"
      render '/product_websites/new'
    end
  end

  private

  def product_website_params
    params.require(:product_website).permit(:website_url, :price_xpath, :sale_price_xpath, :title_xpath, :image_xpath, :price_ajax)
  end
end
