class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # Association
  has_many :properties, dependent: :destroy
  has_many :savedProperties, dependent: :destroy
  # Validation
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+.)+[a-z]{2,})\z/ }
  validates :name, presence: true
  enum role: { landlord: 0, homeseeker: 1 }
  validates :password, length: { minimum: 6 }, confirmation: true
  validates :email, uniqueness: true, presence: true
end
