class ThemeSerializer < ActiveModel::Serializer
  attributes :url
  belongs_to :user

end
