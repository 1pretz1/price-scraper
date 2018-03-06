class ListProductsQuery
  attr_accessor :user

  def initialize(user:)
    @user = user
  end

  def all_ajax
    all_ajax = ProductWebsite.all.where(price_ajax: true).ids
    Product.all.where(product_website_id: all_ajax)
  end

  def all_none_ajax
    all_none_ajax = ProductWebsite.all.where(price_ajax: false).ids
    Product.all.where(product_website_id: all_none_ajax)
  end

  def user_ajax
    fetch_user_website_ids
    ajax = ProductWebsite.where(id: @user_website_ids).where(price_ajax: true).ids
    user.products.where(product_website_id: ajax)
  end

  def user_none_ajax
    fetch_user_website_ids
    none_ajax = ProductWebsite.where(id: @user_website_ids).where(price_ajax: false).ids
    user.products.where(product_website_id: none_ajax)
  end

  def fetch_user_website_ids
    @user_website_ids = user.products.map { |x| x.product_website_id }.uniq
  end
end
