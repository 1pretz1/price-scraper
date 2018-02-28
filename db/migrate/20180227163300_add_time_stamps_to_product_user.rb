class AddTimeStampsToProductUser < ActiveRecord::Migration[5.1]
  def change
     add_column :product_users, :created_at, :datetime, null: false
  end
end
