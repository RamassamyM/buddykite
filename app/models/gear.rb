class Gear < ApplicationRecord
  belongs_to :category
  belongs_to :owner, class_name: :User, foreign_key: :user_id

  validates :address, presence: true
  validates :brand, presence: true
  validates :model, presence: true
  validates :price, presence: true, numericality: { integer: true }
  validates :user_id, presence: true, numericality: { integer: true }
  validates :category_id, presence: true, numericality: { integer: true }
end
