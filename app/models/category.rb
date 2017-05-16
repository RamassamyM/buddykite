class Category < ApplicationRecord
  has_many :sizes
  has_many :gears, through: :sizes
  validates :name, uniqueness: true
end
