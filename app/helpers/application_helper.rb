module ApplicationHelper

  def url_host(url)
    URI(url).host
  end
end
