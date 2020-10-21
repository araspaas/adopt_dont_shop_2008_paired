class Shelter < ApplicationRecord
  has_many :pets
  has_many :applications, through: :pets
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

  def app_count
    applications.distinct.count
  end

  def delete_pets
    pets.each do |pet|
      pet.applications.clear
      pet.delete
    end
  end

  def delete_reviews
    reviews.each do |review|
      review.delete
    end
  end
end
