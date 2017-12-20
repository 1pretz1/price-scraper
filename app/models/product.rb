class Product < ApplicationRecord
  belongs_to :user
  belongs_to :product_website

  validates :product_url, presence: true
  validates :product_url, :url => true

  def self.save_product_attributes(product:, name:, price:, description:, image_url:)
    product.update_attributes(
      name: name,
      price: price,
      description: description,
      image_url: image_url,
    )
  end

  def self.save_sale_price(product:, sale_price:)
    product.update_attributes(
      sale_price: sale_price
    )
  end
end
