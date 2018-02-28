class RemoveUsersForgeinKeyFromProducts < ActiveRecord::Migration[5.1]
  def change
    remove_column :products, :user_id
  end
end
