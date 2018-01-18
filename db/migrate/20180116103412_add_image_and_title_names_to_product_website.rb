class AddImageAndTitleNamesToProductWebsite < ActiveRecord::Migration[5.1]
  def change
    add_column :product_websites, :title_xpath, :string
    add_column :product_websites, :image_xpath, :string
    rename_column :product_websites, :product_price_name, :price_xpath
    rename_column :product_websites, :now_price_name, :sale_price_xpath
  end
end
