class PropertySerializer < ActiveModel::Serializer
  attributes(
    :id, :operation_type, :pets, :maintenance, :bathrooms, :area,
    :bedrooms, :property_type, :price, :about, :address, :active,
    :user_id, :photos_url
  )

  def photos_url
    images = object.images.map do |image|
      rails_blob_path(image, only_path: true) if object.images.attached?
    end
  end
end
