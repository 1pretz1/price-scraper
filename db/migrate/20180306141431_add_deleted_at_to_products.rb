class AddDeletedAtToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :deleted_at, :datetime, default: nil
  end
end
