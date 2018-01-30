class ProductsController < ApplicationController
  include ProductsHelper

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
end
