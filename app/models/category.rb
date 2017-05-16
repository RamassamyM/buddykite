class Category < ApplicationRecord
  has_many :sizes
  validates :name, uniqueness: true
end
