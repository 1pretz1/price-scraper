class ProductsController < ApplicationController
  include ProductsHelper

  before_action :page_scrape, only: [:create]

  def new; end

  def create
    return save_product(existing_product) if existing_product.present?
    if return_website.blank?
      MetaWebsiteAdd.call(product_url: new_product_url, page: page_scrape)
    end
    if return_website.present?
      call_initial_scrape
      #@product = call_initial_scrape
      #if @product.save
      #  ...
      #else
      #  ...
      #end
      product_saved?
    else
      flash[:error] = 'Website not supported at this time!'
      redirect_to new_product_path
    end
  end

  def destroy
    @product = Product.find(params[:id])
    if @product.destroy
      flash[:error] = "'#{@product.name}' successfully deleted!"
    else
      flash[:error] = "'#{@product.name}' could not be deleted, try again!"
    end
    redirect_to "/users/#{current_user.id}"
  end
end
