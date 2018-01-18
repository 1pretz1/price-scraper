class Product < ApplicationRecord
  belongs_to :user
  belongs_to :product_website

  validates :product_url, :name, :price, :image_url, presence: true
  validates :product_url, :url => true

  def self.save_product(user:, product_url:, name:, price:, image_url:, product_website_id:)
    user.products.create(
      product_url: product_url,
      name: name,
      price: price,
      image_url: image_url,
      product_website_id: product_website_id
    )
  end

  def self.save_sale_price(product:, sale_price:)
    product.update_attributes(
      sale_price: sale_price
    )
  end
end
