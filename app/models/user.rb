class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_attachment :photo
  has_many :orders
  has_many :gears
  has_many :own_orders, through: :gears, source: :orders

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :first_name, :last_name, presence: true
  validates :first_name, :last_name, length: { minimum: 2, maximum: 30}
  validates :first_name, :last_name, format: { with: /\A[a-z ,.'-]+\z/i,
    message: "only allows letters" }

end
