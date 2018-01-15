class ProductWebsite < ApplicationRecord
  has_many :products
  validates :website_url, :product_price_name, :now_price_name, presence: true

  def self.add_website(website_url:, product_price_name:, now_price_name:)
    ProductWebsite.create(
      website_url: website_url,
      product_price_name: product_price_name,
      now_price_name: now_price_name
    )
  end
end
