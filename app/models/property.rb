class Property < ApplicationRecord
  # Association
  belongs_to :user
  has_many_attached :photos
  has_many :savedProperties, dependent: :destroy
  # Validations
  enum operation_type: { rent: 0, sale: 1 }
  enum property_type: { apartment: 0, house: 1 }
  validates :about, length: { maximum: 150 }
  # validates :photos, presence: true
  validate :photos_validation


  # after_initialize :assign_defaults_on_new_Property, if: new_record?

  # attr_accesible :pets, :maintenance
  validate :check_user_role
  after_commit :assign_defaults_on_new_property, on: %i[create update]
  

  private

  def assign_defaults_on_new_property
    return unless operation_type == "sale"

    self.pets = true
    self.maintenance = 0
  end

  def check_user_role 
    if user.role == "homeseeker"
      errors.add :base, :invalid, message: "The user should be a landlord to create a property"
      print(errors.full_messages)
      throw :abort

    end
  end

  def photos_validation
    if photos.attached?
        if photos.blob.byte_size > 5000000
          photos.purge
          # errors[:base] << 'Too big'
        end
      end
  end

  # def picture_size_validation
  #   errors[:photos] << "should be less than 5MB" if photos.size > 5.megabytes
  # end
end
