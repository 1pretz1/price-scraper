class DisplayProductFiltersQuery
  include ApplicationHelper
  attr_accessor :user, :items

  def initialize(user:)
    @items = user.products
  end

  def group_by_brand(filter)
    filter.group_by { |x| url_host(x.product_url) }
  end

  def active_items
    group_by_brand(items.where(deleted_at: nil))
  end

  #WIP
  def on_sale
    active_items.select { |x| x.sale_price != nil }
  end
  #

  def deleted_items
    items.where.not(deleted_at: nil)
  end
end
