class DisplayProductFiltersQuery
  include ApplicationHelper
  attr_accessor :user, :items, :active_items

  def initialize(user:)
    @items = user.products
    @active_items = items.where(deleted_at: nil)
  end

  def on_sale_list
    sale_list = active_items.select { |x| x.sale_price != nil }
    group_by_brand(sale_list)
  end

  def active_list
    group_by_brand(active_items)
  end

  def group_by_brand(filter)
    filter.group_by { |x| url_host(x.product_url) }.sort
  end

  def deleted_items
    items.where.not(deleted_at: nil)
  end
end
