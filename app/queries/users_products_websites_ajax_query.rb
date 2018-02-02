class FindByAjax

  def self.call(user:)
    #find all product_website ids for the users products
    #users_website_ids = user.products.map { |x| x.product_website_id }
    #//Finds all ProductWebsite ids that use ajax for users products
    #false = ProductWebsite.where(id: users_website_ids).where(price_ajax: false).ids
    #user.products.where(product_website_id: false)
    #user.products.where(product_website_id: true)
  end
end
