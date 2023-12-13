class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true
  normalizes :email, with: ->(email) { email.downcase }
end
