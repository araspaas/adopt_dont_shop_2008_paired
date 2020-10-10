class Shelter < ApplicationRecord
  has_many :pets
  validates_presence_of :name,
                        :address,
                        :city,
                        :state,
                        :zip


  def count_pets
    pets.count
  end
end
