class Manufacturer < ApplicationRecord
  validates :name, presence: true, length: { maximum: 30 }
  validates :country, presence: true, length: { maximum: 30 }
  has_many :cars
end
