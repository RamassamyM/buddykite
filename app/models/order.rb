class Order < ApplicationRecord
  belongs_to :user
  belongs_to :gear
  validates :start_at, :end_at, presence: true
  validates_date :start_at
  validates_date :end_at, on_or_after: :start_at

end
