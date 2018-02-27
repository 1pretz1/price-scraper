class CreateUsersProducts < ActiveRecord::Migration[5.1]
  def change
    create_join_table :users, :products do |t|
      t.integer :user_id
      t.integer :product_id
    end
  end
end
