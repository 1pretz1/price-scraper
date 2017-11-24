module ApplicationHelper

  def url_host(url)
    uri = URI(url)
    uri.host
  end
end
