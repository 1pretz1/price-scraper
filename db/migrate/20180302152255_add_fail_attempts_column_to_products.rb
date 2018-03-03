class AddFailAttemptsColumnToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :failed_attempts, :float, default: 0
  end
end
