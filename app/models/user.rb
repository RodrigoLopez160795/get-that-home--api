class User < ApplicationRecord
  # Association
  has_many :properties, dependent: :destroy
  has_many :savedProperties, dependent: :destroy
  has_secure_password
  has_secure_token
  # Validation
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+.)+[a-z]{2,})\z/ }
  validates :name, presence: true
  enum role: { landlord: 0, homeseeker: 1 }
  # validates :password, length: { minimum: 6 }, confirmation: true
  validates :email, uniqueness: true, presence: true
end
