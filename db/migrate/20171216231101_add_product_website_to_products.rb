class AddProductWebsiteToProducts < ActiveRecord::Migration[5.1]
  def change
    add_reference :products, :product_website, foreign_key: true
  end
end
