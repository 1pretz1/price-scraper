class ProductsController < ApplicationController
  include ProductsHelper

  def new; end

  def create
    return save_existing_product if return_product.present?

    begin page = page_scrape
    rescue TypeError
      flash[:error] = "Page can't be found!"
      return redirect_to new_product_path
    end

    if return_website.blank?
      website = MetaWebsiteAdd.call(product_url: new_product_url, page: page)
      return website_save_failure if return_website == nil
    end

    return product_scrape_and_save(page) if return_website.present?
  end

  def destroy
    product = Product.find(params[:id])
    product_user = ProductUser.find_by(user_id: current_user.id, product_id: product.id)
    if product.users.count > 1 && product_user.destroy
      delete_flash_notice(product)
    elsif product.destroy && product_user.destroy
      delete_flash_notice(product)
    else
      flash[:error] = "'#{product.name}' could not be deleted, try again!"
    end
    redirect_to "/users/#{current_user.id}"
  end

  def delete_flash_notice(product)
    flash[:error] = "'#{product.name}' successfully deleted!"
  end
end
