class PropertySerializer < ActiveModel::Serializer
  attributes(
    :id, :operation_type, :pets, :maintenance, :bathrooms,
    :bedrooms, :property_type, :price, :about, :address, :active,
    :user_id, :photos_url
  )
end
