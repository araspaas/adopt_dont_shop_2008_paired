class Pet < ApplicationRecord
  belongs_to :shelter
  validates_presence_of :name
  validates_presence_of :age
  validates_presence_of :sex
  validates_presence_of :description
  validates_presence_of :status
  enum status: [:adoptable, :pending, :adopted]
end
