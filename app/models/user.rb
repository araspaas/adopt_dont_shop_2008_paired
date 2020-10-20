class User < ApplicationRecord
  validates_presence_of :name,
                        :address,
                        :city,
                        :state,
                        :zip
  has_many :reviews
  has_many :shelters, through: :reviews
  has_many :applications


  def best_review
    reviews.order(rating: :desc).limit(1).first
  end

  def worst_review
    reviews.order(:rating).limit(1).first
  end
end
