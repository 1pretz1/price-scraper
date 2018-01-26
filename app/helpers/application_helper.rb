module ApplicationHelper

  def flash_class(level)
    case level
    when 'notice' then "alert alert-info"
    when 'success' then "alert alert-success"
    when 'error' then "alert alert-danger"
    when 'alert' then "alert alert-danger"
    end
  end

  def brand(website)
    website.split('.')[1].capitalize
  end

end
