require 'rails_helper'

RSpec.describe Product, type: :model do

  let(:product) { build(:product) }

  describe "creating a product" do
    it "can be created if valid" do
      expect(product).to be_valid
    end

    it "will not be created if product_url is not valid" do
      product.product_url = 'hello'
      expect(product).to_not be_valid
    end
  end
end
