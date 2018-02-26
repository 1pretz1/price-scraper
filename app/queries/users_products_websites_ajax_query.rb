class FindByAjax
  attr_accessor :user, :user_website_ids

  def initialize(user:)
    @users_website_ids = user.products.map { |x| x.product_website_id }
    @user = user
  end

  def self.ajax_list
    ajax = ProductWebsite.where(id: users_website_ids).where(price_ajax: true).ids
    user.products.where(product_website_id: ajax)
  end

  def self.none_ajax_list
    no_ajax = ProductWebsite.where(id: users_website_ids).where(price_ajax: false).ids
    user.products.where(product_website_id: no_ajax)
  end
end
