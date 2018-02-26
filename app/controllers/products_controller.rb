class ProductsController < ApplicationController
  include ProductsHelper

  def new; end

  def create
    return save_existing_product if existing_product.present?

    begin page = page_scrape
    rescue TypeError
      flash[:error] = "Page can't be found!"
      return redirect_to new_product_path
    end

    if return_website.blank?
      website = MetaWebsiteAdd.call(product_url: new_product_url, page: page)
      return website_save_failure if !(website.save)
    end

    return product_scrape_and_save(page) if return_website.present?
  end

  def destroy
    product = Product.find(params[:id])
    if product.destroy
      flash[:error] = "'#{product.name}' successfully deleted!"
    else
      flash[:error] = "'#{product.name}' could not be deleted, try again!"
    end
    redirect_to "/users/#{current_user.id}"
  end
end
