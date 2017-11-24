require 'rails_helper'

RSpec.describe Product, type: :model do
  before do
    @product = FactoryGirl.create(:product)
  end

  describe "creating a product" do
    it "can be created if valid" do
      expect(@product).to be_valid
    end

    it "will not be created if product_url is not valid" do
      @product.product_url = 'hello'
      expect(@product).to_not be_valid
    end
  end
end
