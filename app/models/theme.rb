class Theme < ApplicationRecord
  validates_presence_of :name
  validates :name, uniqueness: true

  belongs_to :user
end
