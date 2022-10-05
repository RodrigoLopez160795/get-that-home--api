class User < ApplicationRecord
  # Association
  has_secure_password
  has_secure_token
  has_many :properties, dependent: :destroy
  has_many :savedProperties, dependent: :destroy
  # Validation
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+.)+[a-z]{2,})\z/ }
  validates :name, presence: true
  enum role: { landlord: 0, homeseeker: 1 }
  # validates :password, length: { minimum: 6 }, confirmation: true
  validates :email, uniqueness: true, presence: true

  def invalidate_token
    update(token: nil)
  end

  def self.authenticate(email, password)
    user = User.find_by(email:)
    return false unless user&.authenticate(password)

    user.regenerate_token
    user
  end
end
