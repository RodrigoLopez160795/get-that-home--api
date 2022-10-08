class Property < ApplicationRecord
  # Association
  belongs_to :user
  has_many_attached :photos
  has_many :savedProperties, dependent: :destroy
  # Validations
  enum operation_type: { rent: 0, sale: 1 }
  enum property_type: { apartment: 0, house: 1 }
  validates :about, length: { maximum: 150 }
  validates :price, numericality: { greater_than: 0 }
  # validates :photos, presence: true
  #after_commit :photos_validation
  validates :photos, size: {  less_than: 5.megabytes , message: 'is too big' }
  # validate validate_photo_size


  validate :check_user_role
  validate :assign_defaults_on_new_property, on: %i[create update]

  def photos_url
    if photos.attached?
      photos.each_with_object([]) do |photo, array|
        array << Rails.application.routes.url_helpers.rails_blob_url(photo)
      end
    end
  end


  private

  # def photos_url
  #   photos.each_With_object([]) do |photo, array|
  #     array << Rails.application.routes.url_helpers.rails_blob_url(photo)
  #   end
  # end

  def assign_defaults_on_new_property
    return unless operation_type == "sale"

    self.pets = true
    self.maintenance = 0
  end

  def check_user_role
    return unless user.role == "homeseeker"

    errors.add :user, :invalid, message: "The user should be a landlord to create a property"
    Rails.logger.debug(errors.full_messages)
    throw :abort
  end

end
