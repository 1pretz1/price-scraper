module UserShowHelper

  def brand(website)
    website.split('.')[1].capitalize
  end

  def deleted
    DisplayProductFiltersQuery.new(user: current_user).deleted_items
  end

  def deleted_message
    flash[:error] = "'#{ deleted.map { |x| x.name }.join(", ") }'
                     have been removed as the URLs are no longer valid!"
  end

  def any_products_removed?
    return deleted_message if deleted.count > 0
  end
end
