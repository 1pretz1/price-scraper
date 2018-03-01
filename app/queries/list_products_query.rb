class ListProductsQuery
  attr_accessor :user, :user_website_ids

  def initialize(user:)
    @user_website_ids = user.products.map { |x| x.product_website_id }.uniq
    @user = user
  end

  def ajax
    ajax = ProductWebsite.where(id: user_website_ids).where(price_ajax: true).ids
    user.products.where(product_website_id: ajax)
  end

  def none_ajax
    no_ajax = ProductWebsite.where(id: user_website_ids).where(price_ajax: false).ids
    user.products.where(product_website_id: no_ajax)
  end
end
