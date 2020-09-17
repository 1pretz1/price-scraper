class HomeController < ApplicationController
  def index
    @products = Product.order("RANDOM()").limit(8)
  end

  def show; end
end
