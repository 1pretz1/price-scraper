class ProductWebsite < ApplicationRecord
  validates :website_url, :product_price_name, :now_price_name, presence: true
end
