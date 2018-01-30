class ChangePriceAjaxInProductWebsiteToDefaultFalse < ActiveRecord::Migration[5.1]
  def change
    change_column_default(:product_websites, :price_ajax, false)
  end
end
