class HomeController < ApplicationController

  def index
    @products = Product.order("RANDOM()").limit(9)
  end

  def show; end
end
