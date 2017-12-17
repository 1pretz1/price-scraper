class ProductWebsite < ApplicationRecord
  has_many :products

  validates :website_url, :now_price_name, presence: true
end
