class RemoveWasPriceNameFromProductWebsite < ActiveRecord::Migration[5.1]
  def change
    remove_column :product_websites, :was_price_name
  end
end
