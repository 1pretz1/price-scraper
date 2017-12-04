class ProductWebsitesController < ApplicationController

  def new
    @product_website = ProductWebsite.new
  end

  def create
    @product_website = ProductWebsite.create(product_website_params)
    if @product_website.save
      flash[:notice] = "Product website has been saved"
      render 'productwebsites/new'
    else
      render 'productwebsites/new'
    end
  end

  private

  def product_website_params
    params.require(:product_website).permit(:website_url, :product_price_name, :now_price_name, :was_price_name)
  end

end
