module UserShowHelper

  def all_users_items
    @all_users_items ||= current_user.products
  end

  def active_items
    @active_items ||= all_users_items.where(deleted_at: nil)
  end

  def sale_items
    @sale_items ||= active_items.select { |x| x.sale_price != nil }
  end

  def total_items_count
    active_items.count
  end

  def total_sale_items_count
    sale_items.count
  end

  def group_by_brand(filter)
    filter.group_by { |x| url_host(x.product_url) }.sort
  end

  def deleted_items
    all_users_items.where.not(deleted_at: nil)
  end

  def any_products_removed?
    return deleted_message if deleted_items.count > 0
  end

  def deleted_message
    flash[:error] = "'#{ deleted.map { |x| x.name }.join(", ") }'
                     have been removed as the URL/s are no longer valid!"
  end

  def brand(website)
    website.split('.')[1].capitalize
  end

  def url_host(url)
    URI(url).host
  end
end
