class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :token
  has_many :themes
  
end
