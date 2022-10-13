class PropertySerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes(
    :id, :operation_type, :pets, :maintenance, :bathrooms, :area,
    :bedrooms, :property_type, :price, :about, :address, :active,
    :user_id, :images_urls
  )
end
