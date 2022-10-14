class PropertySerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes(
    :id, :operation_type, :pets, :maintenance, :bathrooms, :area,
    :bedrooms, :property_type, :price, :about, :address, :active,
    :user_id, :photos_urls
  )

  def photos_urls
    return unless object.photos.attached?

    object.photos.map { |photo| url_for(photo) }
  end
end
