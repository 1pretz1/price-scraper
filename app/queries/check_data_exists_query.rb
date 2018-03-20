class CheckDataExistsQuery
  attr_reader :product_url

  def initialize(product_url)
    @product_url = product_url
  end

  def return_existing_website
    ProductWebsite.all.select do |saved_website|
      product_url.include?(saved_website.website_url)
    end.first
  end

  def return_existing_product
    Product.where(product_url: product_url).first
  end
end
