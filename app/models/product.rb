class Product < ApplicationRecord
  belongs_to :user
  belongs_to :product_website

  validates :product_url, :name, :price, :image_url, :product_website_id, presence: true
  validates :product_url, url: true
end
