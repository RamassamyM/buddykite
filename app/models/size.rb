class Size < ApplicationRecord
  belongs_to :category
  has_many :gears
  validates :name, presence: true, uniqueness: true
  validates :category_id, presence: true
end
