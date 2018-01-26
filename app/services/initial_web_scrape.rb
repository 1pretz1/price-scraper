class InitialWebScrape
  attr_accessor :user, :product_url, :page, :attributes

  def initialize(product_url:, page:, user:)
    @user = user
    @product_url = product_url
    @page = page
    @attributes = {}
  end

  def self.call(*args)
    new(*args).call
  end

  def call
    get_info
    user.products.create(
      user: user,
      product_url: product_url,
      price: attributes[:price],
      name: attributes[:title],
      image_url: attributes[:image],
      product_website_id: attributes[:product_website_id]
    )
  end

  def get_info
    page.remove_namespaces!
    attributes[:title] = page.xpath(return_website.title_xpath).text
    attributes[:image] = page.xpath(return_website.image_xpath).text
    attributes[:product_website_id] = return_website.id
    if page.xpath(return_website.price_xpath).text.present?
      attributes[:price] = page.xpath(return_website.price_xpath).text
      correct_price_format(attributes[:price])
    end
  end

  def correct_price_format(price)
    price = price.gsub(/([^0-9.])/, "")
  end

  def return_website
    ProductWebsite.all.select do |saved_website|
      product_url.include?(saved_website.website_url)
    end.first
  end
end
