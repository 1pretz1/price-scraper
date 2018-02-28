class AddPrimaryKeyToProductUser < ActiveRecord::Migration[5.1]
  def change
    add_column :product_users, :id, :primary_key
  end
end
