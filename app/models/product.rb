class Product < ApplicationRecord
  belongs_to :user

  validates :product_url, presence: true
  validates :product_url, :url => true

end
