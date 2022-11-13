class SavedPropertySerializer < ActiveModel::Serializer
    attributes :id, :favorite, :contacted, :property_id
    belongs_to :property
  
    def product_name
      property.name
    end
  
    # def product_id
    #   object.product.id
    # end
  end