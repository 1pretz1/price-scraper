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
end
