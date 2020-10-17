class Pet < ApplicationRecord
  belongs_to :shelter
  has_many :application_pets
  has_many :applications, through: :application_pets

  validates_presence_of :name
  validates_presence_of :age
  validates_presence_of :sex
  validates_presence_of :description
  validates_presence_of :status
  enum status: [:adoptable, :pending, :adopted]

  def self.search(search)
    Pet.where(name: search)
  end
end
