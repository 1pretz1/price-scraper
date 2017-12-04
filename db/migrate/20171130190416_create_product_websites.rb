class CreateProductWebsites < ActiveRecord::Migration[5.1]
  def change
    create_table :product_websites do |t|
      t.string :website_url
      t.string :product_price_name
      t.string :now_price_name
      t.string :was_price_name
      t.timestamps
    end
  end
end
