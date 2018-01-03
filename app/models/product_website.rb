class ProductWebsite < ApplicationRecord
  has_many :products

  validates :website_url, :product_price_name, :now_price_name, presence: true
end
