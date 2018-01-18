class ProductWebsite < ApplicationRecord
  has_many :products
  validates :website_url, :price_xpath, :sale_price_xpath, :image_xpath, :title_xpath, presence: true

  def self.add_website(page:,
                       product_url:,
                       website_url:,
                       price_xpath:,
                       sale_price_xpath:,
                       image_xpath:,
                       title_xpath:
                      )

    new_website = ProductWebsite.create(
      website_url: website_url,
      price_xpath: price_xpath,
      sale_price_xpath: sale_price_xpath,
      title_xpath: title_xpath,
      image_xpath: image_xpath
    )
  end
end
