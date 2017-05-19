class Order < ApplicationRecord
  belongs_to :user
  belongs_to :gear
  validates :start_at, :end_at, presence: true
  validates_date :start_at, on_or_after: -> { Date.today }
  validates_date :end_at, on_or_after: :start_at

end
