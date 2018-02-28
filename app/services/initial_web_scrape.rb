class InitialWebScrape
  attr_accessor :user, :product_url, :page, :attributes, :website

  def initialize(user:, product_url:, page:, website:)
    @website = website
    @product_url = product_url
    @page = page
    @user = user
    @attributes = {}
  end

  def self.call(*args)
    new(*args).call
  end

  def call
    get_info
    product = Product.create(
      product_url: product_url,
      price: attributes[:price],
      name: attributes[:title],
      image_url: attributes[:image],
      product_website_id: attributes[:product_website_id]
    )
    user.product_users.create(user_id: user.id, product_id: product.id)
  end

  def get_info
    attributes[:title] = page.xpath(website.title_xpath).text
    attributes[:image] = page.xpath(website.image_xpath).text
    attributes[:product_website_id] = website.id
    if page.xpath(website.price_xpath).text.present?
      price = page.xpath(website.price_xpath).text
      attributes[:price] = correct_price_format(price)
    end
  end

  def correct_price_format(price)
    if price.include?('.')
      element = price.split(" ").select { |element| element.include?('.') }.join
      element.gsub(/([^0-9.])/, "")
    elsif price.include?("£")
      element = price.split(" ").select do |x|
        x.include?("£")
      end.join
      element.gsub(/([^0-9.])/, "")
    else
      price.gsub(/([^0-9.])/, "")
    end
  end
end
