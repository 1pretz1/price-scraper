class ProductWebsite < ApplicationRecord
  has_many :products
  validates :website_url, :price_xpath, :sale_price_xpath, :image_xpath, :title_xpath, presence: true
end
