class Car < ApplicationRecord
  validates :model, presence: true, length: { maximum: 30 }
  validates :color, presence: true, length: { maximum: 15 }
  validates :year, presence: true,
            numericality: { greater_than_or_equal_to: 1920, :message => "Year must be after 1920"},
            length: { is: 4 }
  validates :mileage, numericality: true
  validates :description, length: { maximum: 250 }

  belongs_to :manufacturer
end
