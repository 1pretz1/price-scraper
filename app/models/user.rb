class User < ApplicationRecord
  has_many :product_users
  has_many :products, through: :product_users

  has_secure_password
  validates :email, :password, :password_confirmation, presence: true
  validates :email, uniqueness: true
  validates :password, length: { within: 6..40 }
end
