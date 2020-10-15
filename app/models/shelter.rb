class Shelter < ApplicationRecord
  has_many :pets
  has_many :reviews
  has_many :users, through: :reviews
  validates_presence_of :name,
                        :address,
                        :city,
                        :state,
                        :zip


  def count_pets
    pets.count
  end
end
