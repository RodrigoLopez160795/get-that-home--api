class PropertySerializer < ActiveModel::Serializer
  attributes(
    :id, :operation_type, :pets, :maintenance, :bathrooms, :area,
    :bedrooms, :property_type, :price, :about, :address, :active,
    :user_id, :photos_url
  )

  def photos_url
    images = object.images.map do |_image|
      rails_blob_url(@object.image) if object.images.attached?
    end
  end
end
