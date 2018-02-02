class AddBooleanAjaxToProductWebsite < ActiveRecord::Migration[5.1]
  def change
    add_column :product_websites, :price_ajax, :boolean
  end
end
