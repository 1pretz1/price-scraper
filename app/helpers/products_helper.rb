require 'open-uri'

module ProductsHelper

  def page_scrape
    user_agent = 'Mozilla/6.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.0.7)
                 Gecko/2009021910 Firefox/3.0.7'
    begin
      Nokogiri::HTML(open(new_product_url, 'User-agent' => user_agent), nil, 'UTF-8')
                .remove_namespaces!
    rescue TypeError
      flash[:error] = "Page can't be found!"
      redirect_to new_product_path
    end
  end

  def call_initial_scrape
    if return_website.price_ajax == false
      InitialWebScrape.call(product_url: new_product_url,
                            page: page_scrape,
                            website: return_website,
                            user: current_user)
    else
      AjaxScrape.call(url: product_url,
                      website: return_website)
    end
  end

  def product_saved?
    binding.pry
    #need to add product_users table an id for ordering for below command
    if current_user.product_users.last.product_id
      flash[:success] = "'#{current_user.products.last.name}' has been saved"
      redirect_to "/users/#{current_user.id}"
    else
      flash[:error] = 'Product could not be saved, try a different item!'
      redirect_to new_product_path
    end
  end

  def return_website
    ProductWebsite.all.select do |saved_website|
      new_product_url.include?(saved_website.website_url)
    end.first
  end

  def existing_product
    Product.all.select do |product|
      product.product_url == new_product_url
    end.first
  end

  def last_product
    Product.last
  end

  def new_product_url
    params[:product].values.first
  end
end
