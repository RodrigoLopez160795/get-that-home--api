class Property < ApplicationRecord
  # Association
  belongs_to :user
  has_many_attached :photos
  has_many :savedProperties, dependent: :destroy
  # Validations
  enum operation_type: { rent: 0, sale: 1 }
  enum property_type: { apartment: 0, house: 1 }
  validates :operation_type, :property_type, presence: true
  validates :about, length: { maximum: 150 }
  validates :price, numericality: { greater_than: 0 }, presence: true
  validates :address, presence: true
  # validates :photos, presence: true
  # after_commit :photos_validation
  validates :photos, size: { less_than: 5.megabytes }
  # validate validate_photo_size

  validate :check_user_role
  validate :assign_defaults_on_new_property, on: %i[create update]

  private

  def assign_defaults_on_new_property
    self.pets = operation_type == "sale"
    self.maintenance = 0
  end

  def check_user_role
    return unless user.role == "homeseeker"

    errors.add :user, :invalid, message: "The user should be a landlord to create a property"
    Rails.logger.debug(errors.full_messages)
    throw :abort
  end
end
