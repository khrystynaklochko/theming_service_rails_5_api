class User < ApplicationRecord
  has_secure_token
  has_secure_password

  validates :name, :email, presence: true

  has_many :themes, dependent: :destroy
end
