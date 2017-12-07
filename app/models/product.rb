class Product < ApplicationRecord
  belongs_to :user

  validates :product_url, presence: true
  validates :product_url, :url => true

  def self.save_name_and_price(product:, name:, price:)
    product.update_attributes(name: name, price: price)
  end
end
