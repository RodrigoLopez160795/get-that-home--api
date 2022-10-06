class UserSerializer < ActiveModel::Serializer
  attributes :name, :email, :phone, :role, :token
end
