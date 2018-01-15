class ProductsController < ApplicationController
  include ApplicationHelper

  def new
    @product = Product.new
  end

def create
    @product = current_user.products.new(product_params)
    if @product.product_website != nil
      @product.product_website_id = product_website.id
      InitialWebScrape.call(product: @product)
    else
      MetaWebScrape.call(product: @product)
    end
    redirect_to "/users/#{current_user.id}"
    flash[:success] = "'#{@product.name}' has been saved"
  else
    render 'new'
    flash[:error] = "Unable to save that shite!"
  end
end

 private

  def product_website
    ProductWebsite.all.select do |saved_website|
      params[:product].values.first.include?(saved_website.website_url)
    end.first
  end

  def product_params
    params.require(:product).permit(:product_url)
  end
end
