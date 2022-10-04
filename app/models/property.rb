class Property < ApplicationRecord
  #Association
  belongs_to :user
  has_many_attached :photos
  has_many :savedProperties,dependent: :destroy
  #Validations
  enum operation_type: { rent: 0, sale: 1} 
  enum property_type: { apartment: 0, house: 1}

  private

  def check_operation_type
    if operation_type===1
      property.pets = true
      property.maintenance = 0
    end
  end
end
