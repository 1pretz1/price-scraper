require 'open-uri'

module ProductsHelper

  def page_scrape
    user_agent = 'Mozilla/6.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.0.7)
                  Gecko/2009021910 Firefox/3.0.7'
    Nokogiri::HTML(open(new_product_url, 'User-agent' => user_agent), nil, 'UTF-8')
      .remove_namespaces!
  end

  def call_initial_scrape(page)
    if return_website.price_ajax == false
      InitialScrape.call(product_url: new_product_url,
                         page: page,
                         user: current_user,
                         website: return_website)
    else
      InitialAjaxScrape.call(url: new_product_url,
                             user: current_user,
                             website: return_website)
    end
  end

  def save_existing_product
    product_count = current_user.products.count
    current_user.product_users.create(user_id:
                                      current_user.id,
                                      product_id:
                                      existing_product.id)

    new_product_count = current_user.products.count

    if product_count < new_product_count
      product_save_success
    else
      flash[:error] = "'#{existing_product.name}' already exists in your items!"
      redirect_to new_product_path
    end
  end

  def product_scrape_and_save(page)
    product = call_initial_scrape(page)
    if product.save
      product_save_success
    else
      product_save_failure
    end
  end

  def product_save_success
    flash[:success] = "'#{current_user.products.last.name}' has been saved"
    redirect_to "/users/#{current_user.id}"
  end

  def product_save_failure
    flash[:error] = 'Product could not be saved, try a different item!'
    redirect_to new_product_path
  end

  def website_save_failure
    flash[:error] = 'Website not supported at this time!'
    redirect_to new_product_path
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

  def new_product_url
    params[:product].values.first
  end
end
