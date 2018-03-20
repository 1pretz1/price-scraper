require 'open-uri'
module ProductsHelper

  def page_scrape
    user_agent = 'Mozilla/6.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.0.7)
                  Gecko/2009021910 Firefox/3.0.7'
    begin
    Nokogiri::HTML(open(new_product_url, 'User-agent' => user_agent), nil)
      .remove_namespaces!
    rescue OpenURI::HTTPError
      flash[:error] = "Page can't be found! (HTTP error)"
      return redirect_to new_product_path
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

  def call_initial_scrape(page)
    if return_website.price_ajax == false
      InitialScrape.call(product_url: new_product_url,
                         page: page,
                         user: current_user,
                         website: return_website)
    else return_website.price_ajax == true
      InitialAjaxScrape.call(url: new_product_url,
                             user: current_user,
                             website: return_website)
    end
  end

  def save_existing_product
    product = current_user.product_users.create(user_id: current_user.id,
                                                product_id: return_product.id)
    if product.save
      product_save_success
    else
      flash[:error] = "'#{product.name}' already exists in your items!"
      redirect_to new_product_path
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

  def new_product_url
    params[:product].values.first
  end

  def return_website
    @return_website ||= CheckDataExistsQuery.new(new_product_url).return_existing_website
  end

  def return_product
    @return_product ||= CheckDataExistsQuery.new(new_product_url).return_existing_product
  end
end
