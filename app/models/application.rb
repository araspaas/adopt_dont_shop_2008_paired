class Application < ApplicationRecord
  belongs_to :user
  has_many :application_pets
  has_many :pets, through: :application_pets
end
